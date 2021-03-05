import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/home/home_view.dart';
import 'package:qregister/src/app/pages/splash/splash_presenter.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  )   : _presenter = SplashPresenter(userRepository, receiptRepository),
        super();

  @override
  void initListeners() {
    _presenter.initializeAppOnComplete = () async {
      await Future.delayed(Duration(seconds: 2));
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
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.initializeApp();
    super.initController(key);
  }
}
