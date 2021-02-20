import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qreceipt/src/app/pages/camera/camera_view_presenter.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class CameraViewController extends Controller {
  final CameraPresenter _presenter;

  CameraViewController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
  ) : _presenter = CameraPresenter(userRepository, receiptRepository);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController qrViewController;
  Barcode scanResult;

  @override
  void initListeners() {
    _presenter.addReceiptToUserOnNext = (String response) {};

    _presenter.addReceiptToUserOnError = (e) {};
  }

  @override
  void onDisposed() {
    qrViewController?.dispose();
    super.onDisposed();
  }

  void onQRViewCreated(QRViewController response) {
    this.qrViewController = response;
    this.qrViewController.scannedDataStream.listen((scanData) {
      scanResult = scanData;
      refreshUI();
      print('-------- QR DATA --------');
      print(scanResult.code);
    });
  }

  void refreshScreen() {
    refreshUI();
  }
}
