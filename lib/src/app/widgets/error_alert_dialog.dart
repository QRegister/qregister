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
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 75,
              height: 75,
              child: Image.asset(
                'assets/icons/error_cactus.png',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  text1,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.35,
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
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(15),
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
    ),
  );
}
