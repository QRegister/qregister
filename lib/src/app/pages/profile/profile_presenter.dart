import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/domain/usecases/archive_receipt_of_user.dart';
import 'package:qregister/src/domain/usecases/get_current_user.dart';
import 'package:qregister/src/domain/usecases/get_receipts_of_user.dart';
import 'package:qregister/src/domain/usecases/sign_out.dart';

class ProfilePresenter extends Presenter {
  Function getCurrentUserOnNext;
  Function getCurrentUserOnError;

  Function getReceiptsOfUserOnNext;
  Function getReceiptsOfUserOnError;

  Function archiveReceiptOfUserOnNext;
  Function archiveReceiptOfUserOnError;

  Function signOutOnComplete;
  Function signOutOnError;

  final GetCurrentUser _getCurrentUser;
  final GetReceiptsOfUser _getReceiptsOfUser;
  final ArchiveReceiptOfUser _archiveReceiptOfUser;
  final SignOut _signOut;

  ProfilePresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
  )   : _getCurrentUser = GetCurrentUser(userRepository),
        _getReceiptsOfUser = GetReceiptsOfUser(receiptRepository),
        _archiveReceiptOfUser =
            ArchiveReceiptOfUser(receiptRepository, userRepository),
        _signOut = SignOut(authRepository);

  @override
  void dispose() {
    _getCurrentUser.dispose();
    _getReceiptsOfUser.dispose();
    _archiveReceiptOfUser.dispose();
    _signOut.dispose();
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

  void signOut() {
    _signOut.execute(SignOutObserver(this));
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

class SignOutObserver extends Observer<void> {
  final ProfilePresenter _presenter;

  SignOutObserver(this._presenter);
  @override
  void onComplete() {
    assert(_presenter.signOutOnComplete != null);
    _presenter.signOutOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.signOutOnError != null);
    _presenter.signOutOnError(e);
  }

  @override
  void onNext(_) {}
}
