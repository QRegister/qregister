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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(
                  15,
                ),
              ),
              side: BorderSide(
                  color: kPrimaryColor2, width: 2, style: BorderStyle.solid),
            ),
            backgroundColor: kPrimaryColor5,
            content: Container(
              height: 250,
              width: MediaQuery.of(getContext()).size.width * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/icons/receipt_check_icon.png',
                    height: 50,
                  ),
                  Text(
                    'Is this your receipt?',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(getContext()).size.width * 0.045,
                    ),
                  ),
                  Text(
                    response.storeLocation,
                    style: GoogleFonts.openSans(
                      fontSize: MediaQuery.of(getContext()).size.width * 0.043,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    response.totalPrice.toStringAsFixed(2),
                    style: GoogleFonts.openSans(
                      fontSize: MediaQuery.of(getContext()).size.width * 0.043,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(getContext()).pop();
                            scanResult = null;
                          },
                          child: Container(
                            width:
                                MediaQuery.of(getContext()).size.width * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [kPrimaryColor1, kPrimaryColor3],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'No',
                                style: GoogleFonts.openSans(
                                  color: kPrimaryColor5,
                                  fontSize:
                                      MediaQuery.of(getContext()).size.width *
                                          0.043,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextButton(
                          onPressed: () {
                            foundReceipt = response;
                            _presenter.addReceiptIdToStorage(response.id);
                            Navigator.of(getContext()).pop();
                          },
                          child: Container(
                            width:
                                MediaQuery.of(getContext()).size.width * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [kPrimaryColor3, kPrimaryColor1],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: GoogleFonts.openSans(
                                  color: kPrimaryColor5,
                                  fontSize:
                                      MediaQuery.of(getContext()).size.width *
                                          0.043,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    };

    _presenter.getReceiptFromHashOnError = (e) async {
      print(e);
      await showDialog(
        context: getContext(),
        builder: (context) =>
            errorAlertDialog(context, text2: 'Please scan again'),
      );
      scanResult = null;
      refreshUI();
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
