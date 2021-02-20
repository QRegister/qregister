import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/archive/archive_presenter.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';

class ArchiveController extends Controller {
  final ArchivePresenter _presenter;

  ArchiveController(
    ReceiptRepository receiptRepository,
  ) : _presenter = ArchivePresenter(receiptRepository);

  bool isLoading = true;
  List<Receipt> archivedReceiptsOfUser;

  @override
  void onInitState() {
    _presenter.getArchivedReceiptsOfUser();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getArchivedReceiptsOfUserOnNext =
        (List<Receipt> response) async {
      archivedReceiptsOfUser = response;
      isLoading = false;
      await Future.delayed(Duration(milliseconds: 500));
      refreshUI();
    };

    _presenter.getArchivedReceiptsOfUserOnError = (e) {
      print(e);
    };
  }
}
