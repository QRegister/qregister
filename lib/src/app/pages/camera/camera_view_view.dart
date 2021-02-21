import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/camera/camera_view_controller.dart';
import 'package:qregister/src/app/widgets/app_bar_painter.dart';
import 'package:qregister/src/data/repositories/data_receipt_repository.dart';
import 'package:qregister/src/data/repositories/data_user_repository.dart';

class CameraViewView extends View {
  final BuildContext homeContext;

  CameraViewView(this.homeContext);
  @override
  State<StatefulWidget> createState() => _CameraViewViewState(
        CameraViewController(
          DataUserRepository(),
          DataReceiptRepository(),
          homeContext,
        ),
      );
}

class _CameraViewViewState
    extends ViewState<CameraViewView, CameraViewController> {
  _CameraViewViewState(CameraViewController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ControlledWidgetBuilder<CameraViewController>(
              builder: (context, controller) => Stack(
                children: [
                  QRView(
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
                  CustomPaint(
                    size: Size(size.width, size.height + 200),
                    foregroundPainter: AppBarPainter(
                      color: kPrimaryColor1,
                      curveRadius: size.width * 0.75,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: size.height * 0.125,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
