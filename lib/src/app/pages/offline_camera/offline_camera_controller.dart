import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/offline_camera/offline_camera_presenter.dart';
import 'package:qregister/src/app/pages/receipt_details/receipt_details_view.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/file_repository.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';

class OfflineCameraController extends Controller {
  final OfflineCameraPresenter _presenter;

  OfflineCameraController(
      FileRepository fileRepository, InventoryRepository inventoryRepository)
      : _presenter =
            OfflineCameraPresenter(fileRepository, inventoryRepository);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController qrViewController;
  Barcode scanResult;
  Receipt foundReceipt;

  @override
  void initListeners() {
    _presenter.addReceiptIdToStorageOnComplete = () async {
      await Navigator.of(getContext()).push(
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ReceiptDetailsView(
            receipt: foundReceipt,
          ),
        ),
      );
      scanResult = null;
    };

    _presenter.addReceiptIdToStorageOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.getReceiptFromHashOnNext = (Receipt response) async {
      await showDialog(
        context: getContext(),
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Is this your receipt?',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: kPrimaryColor4,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Text(
              'Store: ' +
                  response.storeLocation +
                  '\nTotal Cost: ' +
                  response.totalPrice.toString(),
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(getContext()).pop();
                  scanResult = null;
                },
                child: Text(
                  'Nope',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: kPrimaryColor4.withOpacity(0.5),
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              FlatButton(
                color: kPrimaryColor1,
                onPressed: () {
                  foundReceipt = response;
                  _presenter.addReceiptIdToStorage(response.id);
                  Navigator.of(getContext()).pop();
                },
                child: Text(
                  'Yes!',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    };

    _presenter.getReceiptFromHashOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    qrViewController?.dispose();
    super.onDisposed();
  }

  void onQRViewCreated(QRViewController response) {
    this.qrViewController = response;
    this.qrViewController.scannedDataStream.listen((scanData) {
      if (scanResult == null) {
        scanResult = scanData;
        _presenter.getReceiptFromHash(scanResult.code);
      }
      refreshUI();
    });
  }
}
