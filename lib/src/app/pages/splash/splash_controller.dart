import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/splash/splash_presenter.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  )   : _presenter = SplashPresenter(userRepository, receiptRepository),
        super();

  @override
  void initListeners() {
    _presenter.initializeAppOnComplete = () {};

    _presenter.initializeAppOnError = () {};
  }

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.initializeApp();
    super.initController(key);
  }
}
