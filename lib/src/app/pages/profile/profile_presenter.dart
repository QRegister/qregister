import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';
import 'package:qreceipt/src/domain/usecases/archive_receipt_of_user.dart';
import 'package:qreceipt/src/domain/usecases/get_current_user.dart';
import 'package:qreceipt/src/domain/usecases/get_receipts_of_user.dart';

class ProfilePresenter extends Presenter {
  Function getCurrentUserOnNext;
  Function getCurrentUserOnError;

  Function getReceiptsOfUserOnNext;
  Function getReceiptsOfUserOnError;

  Function archiveReceiptOfUserOnNext;
  Function archiveReceiptOfUserOnError;

  final GetCurrentUser _getCurrentUser;
  final GetReceiptsOfUser _getReceiptsOfUser;
  final ArchiveReceiptOfUser _archiveReceiptOfUser;

  ProfilePresenter(
      UserRepository userRepository, ReceiptRepository receiptRepository)
      : _getCurrentUser = GetCurrentUser(userRepository),
        _getReceiptsOfUser = GetReceiptsOfUser(receiptRepository),
        _archiveReceiptOfUser =
            ArchiveReceiptOfUser(receiptRepository, userRepository);

  @override
  void dispose() {
    _getCurrentUser.dispose();
    _getReceiptsOfUser.dispose();
    _archiveReceiptOfUser.dispose();
  }

  void getCurrentUser() {
    _getCurrentUser.execute(GetCurrentUserObserver(this));
  }

  void getReceiptsOfUser() {
    _getReceiptsOfUser.execute(GetReceiptsOfUserObserver(this));
  }

  void archiveReceiptOfUser(String receiptId) {
    _archiveReceiptOfUser.execute(ArchiveReceiptOfUserObserver(this),
        ArchiveReceiptOfUserParams(receiptId));
  }
}

class GetCurrentUserObserver extends Observer<User> {
  final ProfilePresenter _presenter;

  GetCurrentUserObserver(this._presenter);
  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getCurrentUserOnError != null);
    _presenter.getCurrentUserOnError(e);
  }

  @override
  void onNext(User response) {
    assert(_presenter.getCurrentUserOnNext != null);
    _presenter.getCurrentUserOnNext(response);
  }
}

class GetReceiptsOfUserObserver extends Observer<List<Receipt>> {
  final ProfilePresenter _presenter;

  GetReceiptsOfUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getReceiptsOfUserOnError != null);
    _presenter.getReceiptsOfUserOnError(e);
  }

  @override
  void onNext(List<Receipt> response) {
    assert(_presenter.getReceiptsOfUserOnNext != null);
    _presenter.getReceiptsOfUserOnNext(response);
  }
}

class ArchiveReceiptOfUserObserver extends Observer<String> {
  final ProfilePresenter _presenter;

  ArchiveReceiptOfUserObserver(this._presenter);
  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.archiveReceiptOfUserOnError != null);
    _presenter.archiveReceiptOfUserOnError(e);
  }

  @override
  void onNext(String response) {
    assert(_presenter.archiveReceiptOfUserOnNext != null);
    _presenter.archiveReceiptOfUserOnNext(response);
  }
}
