import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/receipt_details/receipt_details_presenter.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class ReceiptDetailsController extends Controller {
  final ReceiptDetailsPresenter _presenter;

  ReceiptDetailsController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _presenter = ReceiptDetailsPresenter(userRepository, receiptRepository);

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.getReceiptsOfUser();
    super.initController(key);
  }

  @override
  void initListeners() {
    _presenter.getReceiptsOfUserOnNext = (List<Receipt> response) {};

    _presenter.getReceiptsOfUserOnError = (e) {};
  }
}
