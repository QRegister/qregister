import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qregister/src/app/pages/camera/camera_view_presenter.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class CameraViewController extends Controller {
  final CameraPresenter _presenter;
  final BuildContext homeContext;

  CameraViewController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    this.homeContext,
  ) : _presenter = CameraPresenter(userRepository, receiptRepository);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController qrViewController;
  Barcode scanResult;

  @override
  void initListeners() {
    _presenter.addReceiptToUserOnNext = (String response) {
      Scaffold.of(getContext()).showSnackBar(
        SnackBar(
          content: Text("Receipt has been added to your receipt list\n"),
        ),
      );
      scanResult = null;
    };

    _presenter.addReceiptToUserOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.getReceiptByIdOnNext = (Receipt response) async {
      await showDialog(
        context: homeContext,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Is This Your Receipt?',
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
              FlatButton(
                onPressed: () {
                  Navigator.of(homeContext).pop();
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
                  this.addReceiptToUser(response);
                  Navigator.of(homeContext).pop();
                },
                child: Text(
                  'YES!',
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

    _presenter.getReceiptByIdOnError = (e) async {
      showDialog(
        context: homeContext,
        builder: (context) => errorAlertDialog(
          context,
          text1: 'Error',
          text2: 'Please scan again',
        ),
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
        this.getReceiptById(scanResult.code);
      }
      refreshUI();
    });
  }

  void getReceiptById(String receiptId) {
    _presenter.getReceiptById(receiptId);
  }

  void addReceiptToUser(Receipt receipt) {
    _presenter.addReceiptToUser(receipt);
  }

  void refreshScreen() {
    refreshUI();
  }
}
