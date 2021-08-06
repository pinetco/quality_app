import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var bottomCtrl = Get.put(BottomNavigationController());

  @override
  void initState() {
    firebaseNotificationService.init(context);

    super.initState();
  }
  // List<Widget> _widgetOptions = <Widget>[
  //   Home(),
  //   CareGiversList(),
  //   WishMessage(),
  //   ContactInfo(),
  //   Profile(),
  // ];

  CustomNavigationBarItem renderCustomTab(selected, unselected, title) {
    return CustomNavigationBarItem(
      selectedIcon: Image.asset(selected, height: appScreenUtil.size(20)),
      icon: Image.asset(
        unselected,
        height: appScreenUtil.size(20),
      ),
      title: Text(title, style: appCss.bodyStyle7.copyWith(color: appColor.black22Color)),
      selectedTitle: Text(title, style: appCss.bodyStyle7.copyWith(color: appColor.primaryDarkColor)),
    );
  }

  renderTab() {
    if (bottomCtrl.userInfo != null && bottomCtrl.userInfo['role'] != 'client') {
      return [
        renderCustomTab(imageAssets.tab4A, imageAssets.tab4, 'Home'),
        renderCustomTab(imageAssets.tabPatientsA, imageAssets.tabPatients, 'Patients'),
        renderCustomTab(imageAssets.tab1A, imageAssets.tab1, 'Contacts'),
        renderCustomTab(imageAssets.tab2A, imageAssets.tab2, 'Profile'),
      ];
    }
    return [
      renderCustomTab(imageAssets.tab4A, imageAssets.tab4, 'Home'),
      renderCustomTab(imageAssets.tab5A, imageAssets.tab5, 'Care Givers'),
      renderCustomTab(imageAssets.tab3A, imageAssets.tab3, 'Request'),
      renderCustomTab(imageAssets.tab1A, imageAssets.tab1, 'Contacts'),
      renderCustomTab(imageAssets.tab2A, imageAssets.tab2, 'Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: GetBuilder<BottomNavigationController>(builder: (controller) => bottomCtrl.widgetOptions.elementAt(bottomCtrl.currentTab)),
        bottomNavigationBar: GetBuilder<BottomNavigationController>(
          builder: (controller) => CustomNavigationBar(
            // borderRadius: Radius.circular(appScreenUtil.size(30)),
            items: renderTab(),
            currentIndex: bottomCtrl.currentTab,
            selectedColor: appColor.primaryColor,
            unSelectedColor: Color(0XFFCCCCCC),
            strokeColor: appColor.primaryColor,
            onTap: (index) {
              bottomCtrl.updateCurrentTab(index);
            },
          ),
        ));
  }
}
