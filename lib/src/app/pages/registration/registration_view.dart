import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/pages/registration/registration_controller.dart';
import 'package:qregister/src/data/repositories/email_auth_repository.dart';

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

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<RegistrationController>(
        builder: (context, controller) => Container(
          height: size.height,
          width: size.width,
          child: controller.isEmailChecked ? Container() : Container(),
        ),
      ),
    );
  }
}
