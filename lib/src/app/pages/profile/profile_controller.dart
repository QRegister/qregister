import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/profile/profile_presenter.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _presenter = ProfilePresenter(userRepository, receiptRepository);

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.getCurrentUser();
    _presenter.getReceiptsOfUser();
    super.initController(key);
  }

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = (User user) {};

    _presenter.getCurrentUserOnError = (e) {};

    _presenter.getReceiptsOfUserOnNext = (List<Receipt> response) {};

    _presenter.getReceiptsOfUserOnError = (e) {};

    _presenter.archiveReceiptOfUserOnNext = (String response) {};

    _presenter.archiveReceiptOfUserOnError = (e) {};
  }
}
