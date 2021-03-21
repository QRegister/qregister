import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qregister/src/app/pages/profile/profile_presenter.dart';
import 'package:qregister/src/app/pages/splash/splash_view.dart';
import 'package:qregister/src/data/utils/date_time_converter.dart';
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

  List<dynamic> receiptsToDisplay = [];

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
      for (int index = 0; index < response.length; index++) {
        if (index == 0) {
          if (response.first.date.day == DateTime.now().day)
            this.receiptsToDisplay.add('Today');
          else if (response.first.date.day == DateTime.now().day - 1)
            this.receiptsToDisplay.add('Yesterday');
          else
            this.receiptsToDisplay.add(DateTimeConverter.convertDateToString(
                response.elementAt(index).date));

          this.receiptsToDisplay.add(response.elementAt(index));
        } else {
          if (response.elementAt(index).date.day ==
                  response.elementAt(index - 1).date.day ||
              (index - 2 >= 0 &&
                  response.elementAt(index).date.day ==
                      response.elementAt(index - 2).date.day))
            this.receiptsToDisplay.add(response.elementAt(index));
          else {
            if (response.elementAt(index).date.day == DateTime.now().day - 1)
              this.receiptsToDisplay.add('Yesterday');
            else
              this.receiptsToDisplay.add(DateTimeConverter.convertDateToString(
                  response.elementAt(index).date));

            this.receiptsToDisplay.add(response.elementAt(index));
          }
        }
      }
      isLoading = false;
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
      int index = this.receiptsToDisplay.indexWhere(
          (element) => !(element is String) && element.id == response);

      if (this.receiptsToDisplay.elementAt(index - 1) is String &&
          (this.receiptsToDisplay.length == index + 1 ||
              this.receiptsToDisplay.elementAt(index + 1) is String))
        this.receiptsToDisplay.removeAt(index - 1);

      this.receiptsToDisplay.removeWhere(
          (element) => !(element is String) && element.id == response);
      refreshUI();
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
