import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/domain/usecases/add_receipt_to_user.dart';
import 'package:qregister/src/domain/usecases/get_receipt_by_id.dart';

class CameraPresenter extends Presenter {
  Function addReceiptToUserOnNext;
  Function addReceiptToUserOnError;

  Function getReceiptByIdOnNext;
  Function getReceiptByIdOnError;

  final AddReceiptToUser _addReceiptToUser;
  final GetReceiptById _getReceiptById;

  CameraPresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  )   : _addReceiptToUser = AddReceiptToUser(receiptRepository, userRepository),
        _getReceiptById = GetReceiptById(receiptRepository);

  @override
  void dispose() {
    _addReceiptToUser.dispose();
  }

  void addReceiptToUser(Receipt receipt) {
    _addReceiptToUser.execute(
        AddReceiptToUserObserver(this), AddReceiptToUserParams(receipt));
  }

  void getReceiptById(String receiptId) {
    _getReceiptById.execute(
        GetReceiptByIdObserver(this), GetReceiptByIdParams(receiptId));
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

class GetReceiptByIdObserver extends Observer<Receipt> {
  final CameraPresenter _presenter;

  GetReceiptByIdObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getReceiptByIdOnError != null);
    _presenter.getReceiptByIdOnError(e);
  }

  @override
  void onNext(Receipt response) {
    assert(_presenter.getReceiptByIdOnNext != null);
    _presenter.getReceiptByIdOnNext(response);
  }
}
