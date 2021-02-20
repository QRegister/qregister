import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/constants.dart';
import 'package:qreceipt/src/app/pages/splash/splash_controller.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';

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
            'assets/icons/icon_1.png',
            height: size.height / 3.5,
          ),
        ),
      ),
    );
  }
}
