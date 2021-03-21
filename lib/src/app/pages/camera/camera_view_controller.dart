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
      ScaffoldMessenger.of(getContext()).showSnackBar(
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
                            Navigator.of(homeContext).pop();
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
                            this.addReceiptToUser(response);
                            Navigator.of(homeContext).pop();
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
        String id = getReceiptIdFromHash(scanResult.code);
        getReceiptById(id);
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

  String getReceiptIdFromHash(String hash) {
    List<String> itemCodeList = [];
    List<double> itemAmountList = [];
    List<String> otherInfosList = [];
    int index = 0;

    for (int x = 0; x < hash.length; x++) {
      if (hash[x] == "#") {
        otherInfosList.add(hash.substring(index, x));
        index = x + 1;
      } else if (hash[x] == "?") {
        itemCodeList.add(hash.substring(index, x));
        index = x + 1;
      } else if (hash[x] == "%") {
        itemAmountList.add(double.tryParse(hash.substring(index, x)));
        index = x + 1;
      }
    }
    String receiptId = otherInfosList[3];
    return receiptId;
  }
}
