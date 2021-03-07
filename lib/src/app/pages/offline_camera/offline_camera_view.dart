import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/offline_camera/offline_camera_controller.dart';
import 'package:qregister/src/data/repositories/data_inventory_repository.dart';
import 'package:qregister/src/device/repositories/device_file_repository.dart';

class OfflineCameraView extends View {
  @override
  State<StatefulWidget> createState() {
    return _OfflineCameraViewState(
      OfflineCameraController(
        DeviceFileRepository(),
        DataInventoryRepository(),
      ),
    );
  }
}

class _OfflineCameraViewState
    extends ViewState<OfflineCameraView, OfflineCameraController> {
  _OfflineCameraViewState(OfflineCameraController controller)
      : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          ControlledWidgetBuilder<OfflineCameraController>(
            builder: (context, controller) => QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: kPrimaryColor2,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 15,
                cutOutSize: 255,
              ),
              overlayMargin: EdgeInsets.only(top: 50),
            ),
          ),
          Positioned(
            left: 0,
            bottom: size.height * 0.22,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  'Scan QR',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width / 4,
            child: Image.asset(
              'assets/registration_icon.png',
              height: size.height * 0.3,
              width: size.width / 2,
            ),
          ),
          Positioned(
            top: size.height * 0.19,
            right: size.width * 0.27,
            child: Container(
              width: size.width * 0.23,
              height: size.height * 0.04,
              color: Colors.red,
              child: Center(
                child: Text(
                  'OFFLINE',
                  style: GoogleFonts.openSans(
                    color: kPrimaryColor5,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.05,
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              child: Center(
                child: Text(
                  'Your receipt will be uploaded to cloud \nonce you have internet connection',
                  style: GoogleFonts.openSans(
                    color: kPrimaryColor5,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
