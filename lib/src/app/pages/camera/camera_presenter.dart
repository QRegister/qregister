import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';
import 'package:qreceipt/src/domain/usecases/add_receipt_to_user.dart';

class CameraPresenter extends Presenter {
  Function addReceiptToUserOnNext;
  Function addReceiptToUserOnError;

  final AddReceiptToUser _addReceiptToUser;

  CameraPresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _addReceiptToUser = AddReceiptToUser(receiptRepository, userRepository);

  @override
  void dispose() {
    _addReceiptToUser.dispose();
  }

  void addReceiptToUser(Receipt receipt) {
    _addReceiptToUser.execute(
        AddReceiptToUserObserver(this), AddReceiptToUserParams(receipt));
  }
}

class AddReceiptToUserObserver extends Observer<String> {
  final CameraPresenter _presenter;

  AddReceiptToUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.addReceiptToUserOnError != null);
    _presenter.addReceiptToUserOnError(e);
  }

  @override
  void onNext(String response) {
    assert(_presenter.addReceiptToUserOnNext != null);
    _presenter.addReceiptToUserOnNext(response);
  }
}
