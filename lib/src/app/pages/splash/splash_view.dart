import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/splash/splash_controller.dart';
import 'package:qregister/src/data/repositories/data_receipt_repository.dart';
import 'package:qregister/src/data/repositories/data_user_repository.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() => _SplashViewState(
        SplashController(
          DataUserRepository(),
          DataReceiptRepository(),
          EmailAuthRepository(),
        ),
      );
}

class _SplashViewState extends ViewState<SplashView, SplashController> {
  _SplashViewState(SplashController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          child: Image.asset(
            'assets/registration_background.png',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          child: Center(
            child: Image.asset(
              'assets/registration_icon.png',
              height: size.height / 4,
              width: size.width * 0.8,
            ),
          ),
        ),
      ]),
    );
  }
}
