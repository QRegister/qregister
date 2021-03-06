import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/registration/registration_controller.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationView extends View {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationViewState(
      RegistrationController(
        EmailAuthRepository(),
      ),
    );
  }
}

class _RegistrationViewState
    extends ViewState<RegistrationView, RegistrationController> {
  _RegistrationViewState(RegistrationController controller) : super(controller);

  bool resize = false;
  String aboutToBeEmail;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return Scaffold(
      key: globalKey,
      resizeToAvoidBottomInset: resize,
      body: ControlledWidgetBuilder<RegistrationController>(
        builder: (context, controller) => !controller.isEmailChecked
            ? Stack(
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
                          'Enter your email',
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintStyle: GoogleFonts.openSans(
                            color: kPrimaryColor4.withOpacity(0.7),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                          ),
                          hintText: 'example@qregister.com',
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
                        onChanged: (value) => aboutToBeEmail = value,
                        onEditingComplete: () {
                          if (EmailValidator.validate(aboutToBeEmail)) {
                            resize = true;
                            controller.checkIfUserRegistered(aboutToBeEmail);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => errorAlertDialog(
                                context,
                                text1: 'Error',
                                text2: 'Please enter a valid email address',
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: Image.asset(
                      'assets/registration_background.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.13,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.2,
                              ),
                              Image.asset(
                                'assets/registration_icon.png',
                                width: size.width * 0.6,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Container(
                            width: size.width,
                            child: Center(
                              child: Text(
                                'Create an account',
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
                          SizedBox(height: size.height * 0.04),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor4.withOpacity(0.3),
                                  offset: Offset(1, 1),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.12,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: size.width * 0.05,
                                        color: kPrimaryColor2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintStyle: GoogleFonts.openSans(
                                          color:
                                              kPrimaryColor4.withOpacity(0.7),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.5,
                                        ),
                                        hintText: 'First Name',
                                        filled: true,
                                        focusColor: kPrimaryColor5,
                                        hoverColor: kPrimaryColor5,
                                        fillColor: kPrimaryColor5,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor5),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) => firstName = value,
                                      onEditingComplete: () => node.nextFocus(),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.12,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: size.width * 0.05,
                                        color: kPrimaryColor2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintStyle: GoogleFonts.openSans(
                                          color:
                                              kPrimaryColor4.withOpacity(0.7),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.5,
                                        ),
                                        hintText: 'Last Name',
                                        filled: true,
                                        focusColor: kPrimaryColor5,
                                        hoverColor: kPrimaryColor5,
                                        fillColor: kPrimaryColor5,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor5),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) => lastName = value,
                                      onEditingComplete: () => node.nextFocus(),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.12,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: size.width * 0.05,
                                        color: kPrimaryColor2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintStyle: GoogleFonts.openSans(
                                          color:
                                              kPrimaryColor4.withOpacity(0.7),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.5,
                                        ),
                                        hintText: 'Password',
                                        filled: true,
                                        focusColor: kPrimaryColor5,
                                        hoverColor: kPrimaryColor5,
                                        fillColor: kPrimaryColor5,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor5),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) => password = value,
                                      onEditingComplete: () => node.nextFocus(),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.12,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: size.width * 0.05,
                                        color: kPrimaryColor2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintStyle: GoogleFonts.openSans(
                                          color:
                                              kPrimaryColor4.withOpacity(0.7),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.5,
                                        ),
                                        hintText: 'Confirm Password',
                                        filled: true,
                                        focusColor: kPrimaryColor5,
                                        hoverColor: kPrimaryColor5,
                                        fillColor: kPrimaryColor5,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor5),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) =>
                                          confirmPassword = value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              if (password != confirmPassword)
                                showDialog(
                                  context: context,
                                  builder: (context) => errorAlertDialog(
                                    context,
                                    text1: 'Error',
                                    text2: 'Passwords does not match',
                                  ),
                                );
                              else if (password.length < 6)
                                showDialog(
                                  context: context,
                                  builder: (context) => errorAlertDialog(
                                    context,
                                    text1: 'Error',
                                    text2:
                                        'Passwords needs to be at least 6 characters',
                                  ),
                                );
                              else
                                controller.registerUser(
                                    firstName, lastName, password);
                            },
                            child: Image.asset(
                              'assets/icons/submit.png',
                              height: size.height * 0.095,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
