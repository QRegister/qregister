import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
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
  Widget get view => Scaffold(
        body: Container(),
      );
}
