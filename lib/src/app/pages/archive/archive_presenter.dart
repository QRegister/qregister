import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/usecases/get_archived_receipts_of_user.dart';

class ArchivePresenter extends Presenter {
  Function getArchivedReceiptsOfUserOnNext;
  Function getArchivedReceiptsOfUserOnError;

  final GetArchivedReceiptsOfUser _getArchivedReceiptsOfUser;

  ArchivePresenter(
    ReceiptRepository receiptRepository,
  ) : _getArchivedReceiptsOfUser = GetArchivedReceiptsOfUser(receiptRepository);

  @override
  void dispose() {
    _getArchivedReceiptsOfUser.dispose();
  }

  void getArchivedReceiptsOfUser() {
    _getArchivedReceiptsOfUser.execute(GetArchivedReceiptsOfUserObserver(this));
  }
}

class GetArchivedReceiptsOfUserObserver extends Observer<List<Receipt>> {
  final ArchivePresenter _presenter;

  GetArchivedReceiptsOfUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getArchivedReceiptsOfUserOnError != null);
    _presenter.getArchivedReceiptsOfUserOnError(e);
  }

  @override
  void onNext(List<Receipt> response) {
    assert(_presenter.getArchivedReceiptsOfUserOnNext != null);
    _presenter.getArchivedReceiptsOfUserOnNext(response);
  }
}
