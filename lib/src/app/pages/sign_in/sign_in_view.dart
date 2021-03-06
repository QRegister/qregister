import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/sign_in/sign_in_controller.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';

class SignInView extends View {
  final String emailOfUser;

  SignInView(this.emailOfUser);
  @override
  State<StatefulWidget> createState() {
    return _SignInViewState(
      SignInController(
        EmailAuthRepository(),
        emailOfUser,
      ),
    );
  }
}

class _SignInViewState extends ViewState<SignInView, SignInController> {
  _SignInViewState(SignInController controller) : super(controller);
  String password;
  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<SignInController>(
        builder: (context, controller) {
          return Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  'assets/registration_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: size.width * 0.2,
                top: size.height * 0.13,
                child: Image.asset(
                  'assets/registration_icon.png',
                  width: size.width * 0.6,
                ),
              ),
              Positioned(
                top: size.height * 0.37,
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      'Enter your password',
                      style: GoogleFonts.openSans(
                        fontSize: size.width * 0.058,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor5,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: kPrimaryColor4.withOpacity(0.5),
                            offset: Offset(6.0, 6.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.47,
                left: size.width * 0.1,
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor4.withOpacity(0.35),
                        blurRadius: 25,
                        offset: Offset(0, -8),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: size.width * 0.05,
                      color: kPrimaryColor2,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintStyle: GoogleFonts.openSans(
                        color: kPrimaryColor4.withOpacity(0.7),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5,
                      ),
                      hintText: '000000',
                      filled: true,
                      focusColor: kPrimaryColor5,
                      hoverColor: kPrimaryColor5,
                      fillColor: kPrimaryColor5,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    onChanged: (value) => password = value,
                    onEditingComplete: () {
                      if (password.length < 6) {
                        showDialog(
                          context: context,
                          builder: (context) => errorAlertDialog(
                            context,
                            text1: 'Error',
                            text2: 'Passwords are at least 6 characters',
                          ),
                        );
                      } else {
                        controller.signIn(password);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
