import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qreceipt/src/app/constants.dart';
import 'package:qreceipt/src/app/pages/profile/profile_controller.dart';
import 'package:qreceipt/src/data/repositories/data_receipt_repository.dart';
import 'package:qreceipt/src/data/repositories/data_user_repository.dart';

class ProfileView extends View {
  @override
  State<StatefulWidget> createState() => _ProfileViewState(
        ProfileController(
          DataUserRepository(),
          DataReceiptRepository(),
        ),
      );
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
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
                    onPressed: () => print('archive page'),
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
            child: Stack(
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
                Container(
                  width: size.width,
                  height: size.height * 0.69,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      for (int i = 0; i < 20; i++)
                        i % 2 == 0
                            ? receiptCard(context)
                            : SizedBox(
                                height: 20,
                              ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget receiptCard(
  BuildContext context,
) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 35),
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
            child: Icon(
              Icons.store,
              size: 35,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text('Store Name - Receipt'),
          ),
        ],
      ),
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
