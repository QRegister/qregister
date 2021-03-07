import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/home/home_presenter.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;
  final isUploaded;

  HomeController(this.isUploaded) : _presenter = HomePresenter();

  PageController pageController;
  TabController tabController;

  @override
  void onInitState() {
    pageController = PageController(initialPage: 1);

    super.onInitState();
  }

  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {
    if (isUploaded) {
      showDialog(
        context: getContext(),
        builder: (_) => AlertDialog(
          title: Text(
            'Hurray!',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'The receipts you scanned successfully uploaded to cloud',
            style: GoogleFonts.openSans(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(getContext()).pop(),
              child: Text(
                'OK!',
                style: TextStyle(
                  color: kPrimaryColor2,
                ),
              ),
            ),
          ],
        ),
      );
    }
    super.initController(key);
  }

  @override
  void onDisposed() {
    pageController.dispose();
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void initListeners() {}
}
