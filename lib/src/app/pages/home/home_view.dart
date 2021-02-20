import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/constants.dart';
import 'package:qreceipt/src/app/pages/camera/camera_view_view.dart';
import 'package:qreceipt/src/app/pages/home/home_controller.dart';
import 'package:qreceipt/src/app/widgets/app_bar_painter.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => _HomeViewState(
        HomeController(),
      );
}

class _HomeViewState extends ViewState<HomeView, HomeController>
    with SingleTickerProviderStateMixin {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    TabController tabController =
        TabController(length: 3, vsync: this, initialIndex: 1);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: globalKey,
        bottomNavigationBar: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) => ConvexAppBar(
            style: TabStyle.reactCircle,
            initialActiveIndex: 1,
            disableDefaultTabController: true,
            onTap: (int i) {
              controller.pageController.animateToPage(
                i,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutQuart,
              );
            },
            backgroundColor: kPrimaryColor5,
            color: kPrimaryColor4.withOpacity(0.6),
            activeColor: kPrimaryColor1,
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
                onPageChanged: (value) => tabController.animateTo(value),
                children: [
                  Container(),
                  CameraViewView(),
                  Container(),
                ],
              ),
            ),
            CustomPaint(
              size: Size(size.width, size.height + 200),
              foregroundPainter: AppBarPainter(
                color: kPrimaryColor1,
                curveRadius: size.width * 0.75,
              ),
            ),
            Positioned(
              top: -65,
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
