import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/registration/registration_presenter.dart';
import 'package:qregister/src/app/pages/sign_in/sign_in_view.dart';
import 'package:qregister/src/app/pages/splash/splash_view.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class RegistrationController extends Controller {
  final RegistrationPresenter _presenter;

  RegistrationController(AuthRepository authRepository)
      : _presenter = RegistrationPresenter(authRepository),
        super();

  final formKey = GlobalKey<FormState>();

  String emailOfUser;
  bool isEmailChecked = false;

  @override
  void initListeners() {
    _presenter.checkIfUserRegisteredOnNext = (bool response) {
      if (response) {
        Navigator.of(getContext()).pushAndRemoveUntil(
            PageTransition(
              type: PageTransitionType.fade,
              child: SignInView(this.emailOfUser),
            ),
            (route) => false);
      } else {
        isEmailChecked = true;
        refreshUI();
      }
    };

    _presenter.checkIfUserRegisteredOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.registerUserOnNext = (User response) {
      Navigator.of(getContext()).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.fade,
            child: SplashView(),
          ),
          (route) => false);
    };

    _presenter.registerUserOnError = (e) {
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

  void checkIfUserRegistered(String email) {
    this.emailOfUser = email;
    _presenter.checkIfUserRegistered(email);
  }

  void registerUser(
    String firstName,
    String lastName,
    String password,
  ) {
    if (firstName != null &&
        lastName != null &&
        password != null &&
        firstName.length != 0 &&
        lastName.length != 0 &&
        password != null)
      _presenter.registerUser(this.emailOfUser, password, firstName, lastName);
    else {
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(
          context,
          text1: 'Error',
          text2: 'Please fill all the fields',
        ),
      );
    }
  }
}
