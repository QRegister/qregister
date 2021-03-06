import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/sign_in/sign_in_controller.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';

class SignInView extends View {
  final String emailOfUser;

  SignInView(this.emailOfUser);
  @override
  State<StatefulWidget> createState() {
    return _SignInViewState(
      SignInController(
        EmailAuthRepository(),
        emailOfUser,
      ),
    );
  }
}

class _SignInViewState extends ViewState<SignInView, SignInController> {
  _SignInViewState(SignInController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Container(),
    );
  }
}
