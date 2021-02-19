import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';
import 'package:qreceipt/src/domain/usecases/get_receipts_of_user.dart';

class ReceiptDetailsPresenter extends Presenter {
  Function getReceiptsOfUserOnNext;
  Function getReceiptsOfUserOnError;

  final GetReceiptsOfUser _getReceiptsOfUser;

  ReceiptDetailsPresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _getReceiptsOfUser = GetReceiptsOfUser(receiptRepository);

  @override
  void dispose() {
    _getReceiptsOfUser.dispose();
  }

  void getReceiptsOfUser() {
    _getReceiptsOfUser.execute(GetReceiptsOfUserObserver(this));
  }
}

class GetReceiptsOfUserObserver extends Observer<List<Receipt>> {
  final ReceiptDetailsPresenter _presenter;

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
