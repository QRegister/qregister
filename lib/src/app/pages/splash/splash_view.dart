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
          child: Text(
            'QReceipt',
            style: TextStyle(
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[
                    kPrimaryColor1,
                    kPrimaryColor2,
                    kPrimaryColor3,
                    kPrimaryColor4,
                  ],
                ).createShader(
                  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
              fontSize: 60,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
