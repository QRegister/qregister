import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';

import '../../constants.dart';

class ReceiptDetailsView extends StatelessWidget {
  final Receipt receipt;

  ReceiptDetailsView({Key key, this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeHour = receipt.date.hour.toString().length == 1
        ? '0' + receipt.date.hour.toString()
        : receipt.date.hour.toString();
    String timeMinute = receipt.date.minute.toString().length == 1
        ? '0' + receipt.date.minute.toString()
        : receipt.date.minute.toString();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/receipt_background.jpg',
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        receipt.storeLocation,
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        receipt.storeLocationAddress,
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ' +
                            receipt.date.day.toString() +
                            '.' +
                            receipt.date.month.toString() +
                            '.' +
                            receipt.date.year.toString(),
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Time: ' + timeHour + ':' + timeMinute,
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Cashier: ' + receipt.cashierName,
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  child: ListView.builder(
                    itemCount: receipt.products.length,
                    itemBuilder: (context, index) {
                      return productCard(
                          context, receipt.products.elementAt(index));
                    },
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: size.width * 0.81,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: kPrimaryColor2,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Tax: ',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        receipt.totalTax.toStringAsFixed(2),
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        receipt.totalPrice.toStringAsFixed(2),
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor4,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, size.height * 0.09, 0, 0),
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
        ],
      ),
    );
  }
}

Widget productCard(BuildContext context, Product product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.58,
        child: Text(
          product.name,
          style: GoogleFonts.openSans(
            color: kPrimaryColor4,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.63,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(' +
                      product.count.toStringAsFixed(2) +
                      ' x ' +
                      product.unitPrice.toStringAsFixed(2) +
                      ')',
                  style: GoogleFonts.openSans(
                    color: kPrimaryColor4,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '%' + product.taxRate.toString(),
                  style: GoogleFonts.openSans(
                    color: kPrimaryColor4,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Text(
            product.totalPrice.toStringAsFixed(2),
            style: GoogleFonts.openSans(
              color: kPrimaryColor4,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
