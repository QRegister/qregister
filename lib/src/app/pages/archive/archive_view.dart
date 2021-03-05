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
            height: size.height * 0.12,
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
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Archived Receipts',
                      style: GoogleFonts.openSans(
                        color: kPrimaryColor4,
                        fontSize: 25,
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
                        itemCount: controller.archivedReceiptsOfUser.length + 1,
                        itemBuilder: (context, index) {
                          if (index == controller.archivedReceiptsOfUser.length)
                            return SizedBox(
                              height: 60,
                            );
                          else
                            return archivedReceiptCard(
                              context,
                              controller.archivedReceiptsOfUser
                                  .elementAt(index),
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
  bool isStoreExist;
  if (existStores.contains(receipt.storeSlug)) {
    imagePath = 'assets/store_logos/${receipt.storeSlug}.png';
    isStoreExist = true;
  } else {
    imagePath = 'assets/store_logos/default_store.png';
    isStoreExist = false;
  }

  return FlatButton(
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    padding: EdgeInsets.zero,
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            width: size.width - 20,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: archivedReceiptCardShadowList(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    imagePath,
                    width: isStoreExist ? 60 : 60,
                    height: isStoreExist ? 60 : 150,
                  ),
                ),
                Container(
                  width: size.width * 0.52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.4,
                        child: Text(
                          '${receipt.storeLocation}',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        '${receipt.totalPrice.toString()}',
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
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
];
