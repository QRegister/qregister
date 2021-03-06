import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/profile/profile_presenter.dart';
import 'package:qregister/src/app/pages/splash/splash_view.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/app/widgets/error_alert_dialog.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
  ) : _presenter = ProfilePresenter(
          userRepository,
          receiptRepository,
          authRepository,
        );

  bool isLoading = true;

  List<Receipt> receiptsOfUser;

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    _presenter.getCurrentUser();
    _presenter.getReceiptsOfUser();
    super.initController(key);
  }

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = (User user) {};

    _presenter.getCurrentUserOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.getReceiptsOfUserOnNext = (List<Receipt> response) async {
      receiptsOfUser = response;
      isLoading = false;
      await Future.delayed(Duration(milliseconds: 1000));
      refreshUI();
    };

    _presenter.getReceiptsOfUserOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.archiveReceiptOfUserOnNext = (String response) {
      this.receiptsOfUser.removeWhere((element) => element.id == response);
    };

    _presenter.archiveReceiptOfUserOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };

    _presenter.signOutOnComplete = () {
      Navigator.of(getContext()).pushAndRemoveUntil(
          PageTransition(
            type: PageTransitionType.fade,
            child: SplashView(),
          ),
          (route) => false);
    };

    _presenter.signOutOnError = (e) {
      print(e);
      showDialog(
        context: getContext(),
        builder: (context) => errorAlertDialog(context),
      );
    };
  }

  void archiveReceiptOfUser(String id) {
    _presenter.archiveReceiptOfUser(id);
  }

  void signOut() {
    _presenter.signOut();
  }
}
