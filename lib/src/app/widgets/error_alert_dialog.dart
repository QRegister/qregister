import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget errorAlertDialog(
  BuildContext context, {
  String text1 = 'Error',
  String text2 = 'Please try again later',
}) {
  Size size = MediaQuery.of(context).size;
  return AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(
          15,
        ),
      ),
    ),
    content: Container(
      height: text2.length < 48
          ? size.height * 0.16
          : size.height * (0.16 + (text2.length - 48) / 16 * 0.04),
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.018,
              right: size.width * 0.005,
            ),
            child: Container(
              width: size.width * 0.15,
              child: Image.asset(
                'assets/icons/error_cactus.png',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.02,
              top: size.height * 0.013,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.42,
                  child: Text(
                    text2,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width * 0.07,
                height: size.width * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black87,
                  ),
                  borderRadius: BorderRadius.circular(size.width * 0.035),
                ),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
