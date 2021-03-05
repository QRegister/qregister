import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/app/constants.dart';
import 'package:qregister/src/app/pages/camera/camera_view_view.dart';
import 'package:qregister/src/app/pages/home/home_controller.dart';
import 'package:qregister/src/app/pages/info/info_view.dart';
import 'package:qregister/src/app/pages/profile/profile_view.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => _HomeViewState(
        HomeController(),
      );
}

class _HomeViewState extends ViewState<HomeView, HomeController>
    with TickerProviderStateMixin {
  _HomeViewState(HomeController controller) : super(controller);
  TabController tabController;
  int initIndex = 1;

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
              controller.pageController.animateToPage(
                i,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutQuart,
              );
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
