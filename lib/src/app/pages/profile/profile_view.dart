import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qreceipt/src/app/constants.dart';
import 'package:qreceipt/src/app/pages/archive/archive_view.dart';
import 'package:qreceipt/src/app/pages/profile/profile_controller.dart';
import 'package:qreceipt/src/app/widgets/progress_indicators.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';

class ProfileView extends View {
  @override
  State<StatefulWidget> createState() => _ProfileViewState(
        ProfileController(
          DataUserRepository(),
          DataReceiptRepository(),
        ),
      );
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController>
    with TickerProviderStateMixin {
  _ProfileViewState(ProfileController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      colors: [kPrimaryColor1, kPrimaryColor3],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.12,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        'My Receipts',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor5,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.117,
                  right: 25,
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
                )
              ],
            ),
          ),
          Container(
            height: size.height * 0.69,
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
                          colors: [kPrimaryColor1, kPrimaryColor3],
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
                      : controller.receiptsOfUser != null &&
                              controller.receiptsOfUser.length != 0
                          ? Container(
                              width: size.width,
                              height: size.height * 0.69,
                              child: ListView.separated(
                                itemCount: controller.receiptsOfUser.length + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0 ||
                                      index ==
                                          controller.receiptsOfUser.length + 1)
                                    return SizedBox(
                                      height: 60,
                                    );
                                  else
                                    return receiptCard(
                                      context,
                                      controller.receiptsOfUser
                                          .elementAt(index - 1),
                                      controller.archiveReceiptOfUser,
                                    );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(); // Today, Tomorrow
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
                                      'You have no receipts yet\n Scan a QR code to add one',
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
  bool isStoreExist;
  if (existStores.contains(receipt.storeSlug)) {
    imagePath = 'assets/store_logos/${receipt.storeSlug}.png';
    isStoreExist = true;
  } else {
    imagePath = 'assets/store_logos/default_store.png';
    isStoreExist = false;
  }

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Dismissible(
          key: Key(receipt.date.toString()),
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
          onDismissed: (direction) async {
            if (direction == DismissDirection.endToStart) {
              await archiveReceiptOfUser(receipt.id);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Receipt has been archived\n")));
            }
          },
          child: Container(
            width: size.width - 20,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: receiptCardShadowList(),
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
                      Text(
                        '${receipt.storeLocation}',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
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
      ),
      SizedBox(
        height: 30,
      ),
    ],
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
];
