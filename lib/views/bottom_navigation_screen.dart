import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/screen_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var bottomCtrl = Get.put(BottomNavigationController());

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    CareGiversList(),
    WishMessage(),
    FrenchiserInfo(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: GetBuilder<BottomNavigationController>(builder: (controller) => _widgetOptions.elementAt(bottomCtrl.currentTab)),
        bottomNavigationBar: GetBuilder<BottomNavigationController>(
          builder: (controller) => CustomNavigationBar(
            // borderRadius: Radius.circular(screenWidth(30)),
            items: [
              CustomNavigationBarItem(
                selectedIcon: Image.asset(
                  tab4A,
                  height: screenWidth(20),
                ),
                icon: Image.asset(
                  tab4,
                  height: screenWidth(20),
                ),
              ),
              CustomNavigationBarItem(
                selectedIcon: Image.asset(
                  tab5A,
                  height: screenWidth(20),
                ),
                icon: Image.asset(
                  tab5,
                  height: screenWidth(20),
                ),
              ),
              CustomNavigationBarItem(
                selectedIcon: Image.asset(
                  tab3A,
                  height: screenWidth(20),
                ),
                icon: Image.asset(
                  tab3,
                  height: screenWidth(20),
                ),
              ),
              CustomNavigationBarItem(
                selectedIcon: Image.asset(
                  tab1A,
                  height: screenWidth(20),
                ),
                icon: Image.asset(
                  tab1,
                  height: screenWidth(20),
                ),
              ),
              CustomNavigationBarItem(
                selectedIcon: Image.asset(
                  tab2A,
                  height: screenWidth(20),
                ),
                icon: Image.asset(
                  tab2,
                  height: screenWidth(20),
                ),
              ),
            ],
            currentIndex: bottomCtrl.currentTab,
            selectedColor: primaryColor,
            unSelectedColor: Color(0XFFCCCCCC),
            strokeColor: primaryColor,
            onTap: (index) {
              bottomCtrl.updateCurrentTab(index);
            },
          ),
        ));
  }
}
