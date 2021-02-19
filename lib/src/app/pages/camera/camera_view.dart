import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/camera/camera_controller.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';

class CameraView extends View {
  @override
  State<StatefulWidget> createState() => _CameraViewState(
        CameraController(
          DataUserRepository(),
          DataReceiptRepository(),
        ),
      );
}

class _CameraViewState extends ViewState<CameraView, CameraController> {
  _CameraViewState(CameraController controller) : super(controller);

  @override
  Widget get view => Scaffold(
        body: Container(),
      );
}
