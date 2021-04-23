import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/config_package.dart';
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

  // List<Widget> _widgetOptions = <Widget>[
  //   Home(),
  //   CareGiversList(),
  //   WishMessage(),
  //   ContactInfo(),
  //   Profile(),
  // ];

  CustomNavigationBarItem renderCustomTab(selected, unselected, title) {
    return CustomNavigationBarItem(
      selectedIcon: Image.asset(selected, height: screenHeight(20)),
      icon: Image.asset(
        unselected,
        height: screenHeight(20),
      ),
      title: Text(title, style: bodyStyle7.copyWith(color: black22Color)),
      selectedTitle: Text(title, style: bodyStyle7.copyWith(color: primaryDarkColor)),
    );
  }

  renderTab() {
    if (bottomCtrl.userInfo != null && bottomCtrl.userInfo['role'] != 'client') {
      return [
        renderCustomTab(tab4A, tab4, 'Home'),
        renderCustomTab(tabPatientsA, tabPatients, 'Patients'),
        renderCustomTab(tab1A, tab1, 'Contacts'),
        renderCustomTab(tab2A, tab2, 'Profile'),
      ];
    }
    return [
      renderCustomTab(tab4A, tab4, 'Home'),
      renderCustomTab(tab5A, tab5, 'Care Givers'),
      renderCustomTab(tab3A, tab3, 'Request'),
      renderCustomTab(tab1A, tab1, 'Contacts'),
      renderCustomTab(tab2A, tab2, 'Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: GetBuilder<BottomNavigationController>(builder: (controller) => bottomCtrl.widgetOptions.elementAt(bottomCtrl.currentTab)),
        bottomNavigationBar: GetBuilder<BottomNavigationController>(
          builder: (controller) => CustomNavigationBar(
            // borderRadius: Radius.circular(screenWidth(30)),
            items: renderTab(),
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
