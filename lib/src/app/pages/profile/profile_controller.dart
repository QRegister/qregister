import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/profile/profile_presenter.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _presenter = ProfilePresenter(userRepository, receiptRepository);

  bool isLoading = true;

  List<Receipt> receiptsOfUser;

  @override
  void onInitState() {
    super.onInitState();
  }

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

    _presenter.getReceiptsOfUserOnNext = (List<Receipt> response) async {
      receiptsOfUser = response;
      isLoading = false;
      await Future.delayed(Duration(milliseconds: 1000));
      refreshUI();
    };

    _presenter.getReceiptsOfUserOnError = (e) {
      print(e);
    };

    _presenter.archiveReceiptOfUserOnNext = (String response) {
      this.receiptsOfUser.removeWhere((element) => element.id == response);
    };

    _presenter.archiveReceiptOfUserOnError = (e) {};
  }

  void archiveReceiptOfUser(String id) {
    _presenter.archiveReceiptOfUser(id);
  }
}
