import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/archive/archive_view.dart';
import 'package:qregister/src/app/pages/profile/profile_controller.dart';
import 'package:qregister/src/app/pages/receipt_details/receipt_details_view.dart';
import 'package:qregister/src/app/widgets/progress_indicators.dart';
import 'package:qregister/src/data/repositories/data_receipt_repository.dart';
import 'package:qregister/src/data/repositories/data_user_repository.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';
import 'package:qregister/src/domain/entities/receipt.dart';

class ProfileView extends View {
  @override
  State<StatefulWidget> createState() => _ProfileViewState(
        ProfileController(
          DataUserRepository(),
          DataReceiptRepository(),
          EmailAuthRepository(),
        ),
      );
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController>
    with TickerProviderStateMixin {
  _ProfileViewState(ProfileController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    double heightDiff = size.height > 820
        ? -14
        : size.height > 750
            ? size.height - 752
            : 0;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff96D68B),
                        kPrimaryColor3,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.125,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        'My Receipts',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor5,
                          fontSize: size.width * 0.075,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.117,
                  left: size.width * 0.07,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: ArchiveView(),
                      ),
                    ),
                    icon: Icon(
                      Icons.archive,
                      size: 30,
                      color: kPrimaryColor5,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.117,
                  right: size.width * 0.07,
                  child: ControlledWidgetBuilder<ProfileController>(
                    builder: (context, controller) => IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Warning',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              'You are about to be signed out. Are you sure?',
                              style: GoogleFonts.openSans(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: kPrimaryColor4.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => controller.signOut(),
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    color: Colors.red[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        FontAwesomeIcons.signOutAlt,
                        size: 30,
                        color: kPrimaryColor5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.69 - heightDiff,
            child: ControlledWidgetBuilder<ProfileController>(
              builder: (context, controller) => Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: size.height * 0.07,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff96D68B),
                            kPrimaryColor3,
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            size.width / 2,
                            size.height * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller.isLoading
                      ? Align(
                          alignment: Alignment.center,
                          child: kJumpingDotsProgressIndicator(kPrimaryColor1),
                        )
                      : controller.receiptsToDisplay != null &&
                              controller.receiptsToDisplay.length != 0
                          ? Container(
                              width: size.width,
                              height: size.height * 0.69,
                              child: ListView.builder(
                                itemCount:
                                    controller.receiptsToDisplay.length + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0 ||
                                      index ==
                                          controller.receiptsToDisplay.length +
                                              1)
                                    return SizedBox(
                                      height: 45,
                                    );
                                  else if (controller.receiptsToDisplay
                                      .elementAt(index - 1) is String)
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.09,
                                        bottom: 8,
                                        top: 8,
                                      ),
                                      child: Text(
                                        controller.receiptsToDisplay
                                            .elementAt(index - 1),
                                        style: GoogleFonts.openSans(
                                          color:
                                              kPrimaryColor4.withOpacity(0.4),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  else
                                    return receiptCard(
                                      context,
                                      controller.receiptsToDisplay
                                          .elementAt(index - 1),
                                      controller.archiveReceiptOfUser,
                                    );
                                },
                              ),
                            )
                          : Container(
                              width: size.width,
                              height: size.height * 0.69,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/no_receipt_found.png',
                                    height: size.height * 0.25,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'You have no recent receipts\n Scan a QR code to add one',
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget receiptCard(
  BuildContext context,
  Receipt receipt,
  Function archiveReceiptOfUser,
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
          ),
          child: Dismissible(
            key: Key(
              receipt.id.toString(),
            ),
            background: Container(),
            secondaryBackground: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.archive_outlined,
                  color: kPrimaryColor3,
                  size: 30,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                await archiveReceiptOfUser(receipt.id);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Receipt has been archived\n")));
                return true;
              } else {
                return false;
              }
            },
            child: Container(
              width: size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: receiptCardShadowList(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Image.asset(
                      imagePath,
                      width: size.width * 0.15,
                      height: 50,
                    ),
                  ),
                  Container(
                    width: size.width * 0.54,
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
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    ),
  );
}

List<BoxShadow> receiptCardShadowList() {
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
