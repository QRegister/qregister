import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/splash/splash_controller.dart';
import 'package:qregister/src/data/repositories/data_receipt_repository.dart';
import 'package:qregister/src/data/repositories/data_user_repository.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() => _SplashViewState(
        SplashController(
          DataUserRepository(),
          DataReceiptRepository(),
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
      body: Container(
        width: size.width,
        height: size.height,
        child: Center(
          child: Image.asset(
            'assets/icons/icon_2.png',
            height: size.height / 3,
          ),
        ),
      ),
    );
  }
}
