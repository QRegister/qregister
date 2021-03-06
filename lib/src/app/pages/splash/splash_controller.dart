import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/home/home_view.dart';
import 'package:qregister/src/app/pages/registration/registration_view.dart';
import 'package:qregister/src/app/pages/splash/splash_presenter.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
  )   : _presenter = SplashPresenter(
          userRepository,
          receiptRepository,
          authRepository,
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
        Navigator.of(getContext()).pushAndRemoveUntil(
            PageTransition(
              type: PageTransitionType.fade,
              child: RegistrationView(),
            ),
            (route) => false);
      }
    };

    _presenter.checkIfUserSignedInOnError = (e) {
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
    _presenter.checkIfUserSignedIn();
    super.initController(key);
  }
}
