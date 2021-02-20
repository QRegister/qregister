import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/home/home_presenter.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController() : _presenter = HomePresenter();

  PageController pageController;
  TabController tabController;

  @override
  void onInitState() {
    pageController = PageController(initialPage: 1);

    super.onInitState();
  }

  @override
  void onDisposed() {
    pageController.dispose();
    super.onDisposed();
  }

  @override
  void initListeners() {}
}