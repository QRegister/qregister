import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/camera/camera_presenter.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class CameraController extends Controller {
  final CameraPresenter _presenter;

  CameraController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _presenter = CameraPresenter(userRepository, receiptRepository);

  @override
  void initListeners() {
    _presenter.addReceiptToUserOnNext = (String response) {};

    _presenter.addReceiptToUserOnError = (e) {};
  }
}
