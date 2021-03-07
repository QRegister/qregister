import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/home/home_view.dart';
import 'package:qregister/src/app/pages/offline_camera/offline_camera_view.dart';
import 'package:qregister/src/app/pages/registration/registration_view.dart';
import 'package:qregister/src/app/pages/splash/splash_presenter.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/internet_repository.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
    InternetRepository internetRepository,
    InventoryRepository inventoryRepository,
  )   : _presenter = SplashPresenter(
          userRepository,
          receiptRepository,
          authRepository,
          internetRepository,
          inventoryRepository,
        ),
        super();

  @override
  void initListeners() {
    _presenter.initializeAppOnComplete = () async {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(getContext()).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.fade,
            child: HomeView(),
          ),
          (route) => false);
    };

    _presenter.initializeAppOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.checkIfUserSignedInOnNext = (bool response) async {
      if (response) {
        _presenter.initializeApp();
      } else {
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(getContext()).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.fade,
            child: RegistrationView(),
          ),
          (route) => false,
        );
      }
    };

    _presenter.checkIfUserSignedInOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.checkIfUserHasInternetOnNext = (bool response) {
      if (response) {
        _presenter.checkIfUserSignedIn();
      } else {
        _presenter.readInventoryCsv();
      }
    };

    _presenter.checkIfUserHasInternetOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.readInventoryCsvOnComplete = () {
      Navigator.of(getContext()).pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.fade,
          child: OfflineCameraView(),
        ),
        (route) => false,
      );
    };

    _presenter.readInventoryCsvOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.checkIfUserHasInternet();
    super.initController(key);
  }
}
