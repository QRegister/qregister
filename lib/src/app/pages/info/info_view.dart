import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qregister/src/app/constants.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightDiff = (size.height - 750) > 0 ? size.height - 750 : 0;
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
                      colors: [kPrimaryColor3, kPrimaryColor1],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.12,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        'Welcome To QRegister',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor5,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColor3,
                  kPrimaryColor1,
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
          Container(
            width: size.width * 0.8,
            height: size.height * 0.63,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView(
                children: [
                  Text(
                    '\nTutorial\n',
                    style: titleTextStyle,
                  ),
                  Text(
                    'Home:',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  You can scan your QR code by aligning it into the square camera view. The scanning is an automatic procedure, you don’t need to press any buttons. After the scanning is complete, your receipt will be visible on the Profile page.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    'Profile:',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  You can access this page by swiping left on the Home page, or you can navigate using the bottom bar by tapping on the “Profile” icon on the far right. Your profile contains all the past receipts and their details. The receipts are listed by their dates and labeled with supermarket icons for glancing through quickly. You can use the search button on the upper right corner to search keywords from your receipts. The star button on the upper left corner archives important receipts for easy access in the future. Tap on any receipt to view the details of your purchase.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    'Info:',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  You can access the Information page by swiping right on the Home page or tapping on the “Info” icon on the left of the bottom bar. The tutorial, Frequently Asked Questions (FAQ), last updates and, contact information, are featured on the Info page.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nFrequently Asked Questions (FAQ)\n',
                    style: titleTextStyle,
                  ),
                  Text(
                    'Why should I prefer an electronic receipt?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  Every year, in the United States alone, producing paper receipts takes about 1 million liters of oil, uses a million liters of water, destroys 10 million trees, generates 2 billion kilograms of carbon dioxide, and causes 137 million kilograms of solid waste. Take into consideration that most of the paper receipts are checked only once and then end up in the trash. Besides, the paper receipts are coated with BPA (Bisphenol A), a plastic chemical that is presumed to cause cancer, obesity, type 2 diabetes, and premature puberty. The paper receipts also increase the COVID-19 contamination by increasing contact at the supermarkets. Moreover, the receipts are very hard to store, carry and keep track of. ',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nI don’t have cellular data. Will QRegister still function?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  Yes. You will be able to view your receipts right away, even if you are disconnected. Once you connect to the internet, your receipts will be saved safely.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nIf I delete QRegister, will my previous receipts be deleted?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  No. We are keeping your old receipts saved and safe. If you ever remove the app and re-download, your receipts will still be available.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nWhich details of paper receipts are featured on QRegister?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  We store every information users and cashiers need in your electronic receipts. Specifically, we store the supermarket’s name, branch, and location; the products’ names, barcode numbers, quantity, fax rates, and prices; the purchase’s date, time, total fax, and total price.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nIs my data safe?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  Yes. We use several Google technologies to keep your purchase data safe.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nI did not understand some parts of the tutorial. Where can I get extra support?',
                    style: boldTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  You can receive support any time by contacting our support team via qregisterhelp@gmail.com.',
                      style: normalTextStyle,
                    ),
                  ),
                  Text(
                    '\nContact Information',
                    style: titleTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '  We would love to hear your feedback and answer your further questions. E-mail our team at qregisterhelp@gmail.com \n\nWe are a devoted team of four engineering students. \n\nHumeyra Bodur, Alkım Dömeke, Deniz Karakay, Murat Kaş',
                      style: normalTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 50,
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

TextStyle titleTextStyle = GoogleFonts.openSans(
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor4,
);

TextStyle boldTextStyle = GoogleFonts.openSans(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor4,
);

TextStyle normalTextStyle = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor4,
);
