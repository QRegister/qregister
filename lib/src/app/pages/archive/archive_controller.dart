import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/archive/archive_presenter.dart';
import 'package:qregister/src/data/utils/date_time_converter.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class ArchiveController extends Controller {
  final ArchivePresenter _presenter;

  ArchiveController(
    ReceiptRepository receiptRepository,
  ) : _presenter = ArchivePresenter(receiptRepository);

  bool isLoading = true;
  List<dynamic> receiptsToDisplay = [];

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
      for (int index = 0; index < response.length; index++) {
        if (index == 0) {
          if (response.first.date.day == DateTime.now().day)
            this.receiptsToDisplay.add('Today');
          else if (response.first.date.day == DateTime.now().day - 1)
            this.receiptsToDisplay.add('Yesterday');
          else
            this.receiptsToDisplay.add(DateTimeConverter.convertDateToString(
                response.elementAt(index).date));

          this.receiptsToDisplay.add(response.elementAt(index));
        } else {
          if (response.elementAt(index).date.day ==
                  response.elementAt(index - 1).date.day ||
              (index - 2 >= 0 &&
                  response.elementAt(index).date.day ==
                      response.elementAt(index - 2).date.day))
            this.receiptsToDisplay.add(response.elementAt(index));
          else {
            if (response.elementAt(index).date.day == DateTime.now().day - 1)
              this.receiptsToDisplay.add('Yesterday');
            else
              this.receiptsToDisplay.add(DateTimeConverter.convertDateToString(
                  response.elementAt(index).date));

            this.receiptsToDisplay.add(response.elementAt(index));
          }
        }
      }

      isLoading = false;
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
