import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/camera/camera_view_view.dart';
import 'package:qregister/src/app/pages/home/home_controller.dart';
import 'package:qregister/src/app/pages/info/info_view.dart';
import 'package:qregister/src/app/pages/profile/profile_view.dart';

class HomeView extends View {
  final bool isUploaded;

  HomeView(this.isUploaded);
  @override
  State<StatefulWidget> createState() => _HomeViewState(
        HomeController(isUploaded),
      );
}

class _HomeViewState extends ViewState<HomeView, HomeController>
    with TickerProviderStateMixin {
  _HomeViewState(HomeController controller) : super(controller);
  TabController tabController;
  int initIndex = 1;

  @override
  void initState() {
    if (widget.isUploaded) {
      Timer.run(
        () {
          showDialog(
            context: context,
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
                  onPressed: () => Navigator.of(context).pop(),
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
        },
      );
    }
    super.initState();
  }

  @override
  Widget get view {
    tabController =
        TabController(length: 3, vsync: this, initialIndex: initIndex);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: globalKey,
        bottomNavigationBar: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) => ConvexAppBar(
            style: TabStyle.reactCircle,
            initialActiveIndex: initIndex,
            disableDefaultTabController: true,
            onTap: (int i) {
              initIndex = i;
              controller.pageController.jumpToPage(i);
            },
            backgroundColor: kPrimaryColor5,
            color: kPrimaryColor4.withOpacity(0.6),
            activeColor: kPrimaryColor1,
            top: -20,
            items: [
              TabItem(icon: Icons.info_outline, title: 'Info'),
              TabItem(icon: Icons.home_outlined, title: 'Home'),
              TabItem(icon: Icons.person_outline_outlined, title: 'Profile'),
            ],
            controller: tabController,
          ),
        ),
        body: Stack(
          children: [
            ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) => PageView(
                controller: controller.pageController,
                onPageChanged: (value) {
                  initIndex = value;
                  tabController.animateTo(value);
                },
                children: [
                  InfoView(),
                  CameraViewView(context),
                  ProfileView(),
                ],
              ),
            ),
            Positioned(
              top: -60,
              left: size.width / 4,
              child: Image.asset(
                'assets/icons/app_bar_icon.png',
                height: 200,
                width: size.width / 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
