import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/receipt_details/receipt_details_controller.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';

class ReceiptDetailsView extends View {
  @override
  State<StatefulWidget> createState() => _ReceiptDetailsViewState(
        ReceiptDetailsController(
          DataUserRepository(),
          DataReceiptRepository(),
        ),
      );
}

class _ReceiptDetailsViewState
    extends ViewState<ReceiptDetailsView, ReceiptDetailsController> {
  _ReceiptDetailsViewState(ReceiptDetailsController controller)
      : super(controller);

  @override
  Widget get view => Scaffold(
        body: Container(),
      );
}
