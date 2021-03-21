import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/archive/archive_controller.dart';
import 'package:qregister/src/app/pages/receipt_details/receipt_details_view.dart';
import 'package:qregister/src/app/widgets/progress_indicators.dart';
import 'package:qregister/src/data/repositories/data_receipt_repository.dart';
import 'package:qregister/src/domain/entities/receipt.dart';

class ArchiveView extends View {
  @override
  State<StatefulWidget> createState() => _ArchiveViewState(
        ArchiveController(
          DataReceiptRepository(),
        ),
      );
}

class _ArchiveViewState extends ViewState<ArchiveView, ArchiveController> {
  _ArchiveViewState(ArchiveController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.11,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor4,
                        size: size.width * 0.08,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      ' Archived Receipts',
                      style: GoogleFonts.openSans(
                        color: kPrimaryColor4,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ControlledWidgetBuilder<ArchiveController>(
            builder: (context, controller) => Container(
              width: size.width,
              height: size.height * 0.85,
              child: controller.isLoading
                  ? kJumpingDotsProgressIndicator(kPrimaryColor1)
                  : NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: ListView.builder(
                        itemCount: controller.receiptsToDisplay.length + 1,
                        itemBuilder: (context, index) {
                          if (index == controller.receiptsToDisplay.length)
                            return SizedBox(
                              height: 45,
                            );
                          else if (controller.receiptsToDisplay.elementAt(index)
                              is String)
                            return Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.09,
                                bottom: 8,
                                top: 8,
                              ),
                              child: Text(
                                controller.receiptsToDisplay.elementAt(index),
                                style: GoogleFonts.openSans(
                                  color: kPrimaryColor4.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          else
                            return archivedReceiptCard(
                              context,
                              controller.receiptsToDisplay.elementAt(index),
                            );
                        },
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

Widget archivedReceiptCard(
  BuildContext context,
  Receipt receipt,
) {
  Size size = MediaQuery.of(context).size;
  String imagePath;
  if (existStores.contains(receipt.storeSlug)) {
    imagePath = 'assets/store_logos/${receipt.storeSlug}.png';
  } else {
    imagePath = 'assets/store_logos/default_store.png';
  }

  return TextButton(
    onPressed: () => Navigator.of(context).push(
      PageTransition(
        child: ReceiptDetailsView(
          receipt: receipt,
        ),
        type: PageTransitionType.rightToLeft,
      ),
    ),
    child: Column(
      children: [
        Container(
          width: size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: archivedReceiptCardShadowList(),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Image.asset(
                  imagePath,
                  width: size.width * 0.15,
                  height: 50,
                ),
              ),
              Container(
                width: size.width * 0.55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: size.width * 0.4,
                          maxWidth: size.width * 0.4,
                          minHeight: size.height * 0.08,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${receipt.storeLocation}',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.035,
                                color: kPrimaryColor4.withOpacity(0.6),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '${receipt.totalPrice.toString()}',
                      style: GoogleFonts.openSans(
                        color: kPrimaryColor4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    ),
  );
}

List<BoxShadow> archivedReceiptCardShadowList() {
  return [
    BoxShadow(
      color: Colors.black12.withOpacity(0.15),
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(
        0,
        5,
      ),
    ),
  ];
}

const List<String> existStores = [
  'migros',
  'carrefour',
  'a101',
  'sok',
  'bim',
  'metro'
];
