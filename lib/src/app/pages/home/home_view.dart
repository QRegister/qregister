import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/camera/camera_view_view.dart';
import 'package:qreceipt/src/app/pages/home/home_controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => _HomeViewState(
        HomeController(),
      );
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CameraViewView(),
    );
  }
}
