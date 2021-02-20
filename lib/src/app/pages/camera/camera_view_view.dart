import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qreceipt/src/app/pages/camera/camera_view_controller.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';

class CameraViewView extends View {
  @override
  State<StatefulWidget> createState() => _CameraViewViewState(
        CameraViewController(
          DataUserRepository(),
          DataReceiptRepository(),
        ),
      );
}

class _CameraViewViewState
    extends ViewState<CameraViewView, CameraViewController> {
  _CameraViewViewState(CameraViewController controller) : super(controller);

  @override
  Widget get view => Scaffold(
        body: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: ControlledWidgetBuilder<CameraViewController>(
                  builder: (context, controller) => QRView(
                    key: controller.qrKey,
                    onQRViewCreated: controller.onQRViewCreated,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
