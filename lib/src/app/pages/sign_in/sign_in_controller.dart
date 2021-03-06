import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/sign_in/sign_in_presenter.dart';
import 'package:qregister/src/app/pages/splash/splash_view.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class SignInController extends Controller {
  final SignInPresenter _presenter;
  final String emailOfUser;

  SignInController(AuthRepository authRepository, this.emailOfUser)
      : _presenter = SignInPresenter(authRepository);

  @override
  void initListeners() {
    _presenter.signInOnNext = (String response) {
      Navigator.of(getContext()).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.fade,
            child: SplashView(),
          ),
          (route) => false);
    };

    _presenter.signInOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(
          context,
          text1: 'Error',
          text2: 'Email or password is incorrect',
        ),
      );
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void signIn(String password) {
    _presenter.signIn(this.emailOfUser, password);
  }
}
