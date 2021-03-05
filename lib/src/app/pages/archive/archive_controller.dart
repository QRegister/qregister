import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/archive/archive_presenter.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class ArchiveController extends Controller {
  final ArchivePresenter _presenter;

  ArchiveController(
    ReceiptRepository receiptRepository,
  ) : _presenter = ArchivePresenter(receiptRepository);

  bool isLoading = true;
  List<Receipt> archivedReceiptsOfUser;

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

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
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };
  }
}
