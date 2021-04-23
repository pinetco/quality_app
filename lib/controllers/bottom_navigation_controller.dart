import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/screen_package.dart';

class BottomNavigationController extends GetxController {
  int _currentTab = 0;
  dynamic userInfo;
  // final box = GetStorage();

  int get currentTab => _currentTab;
  List widgetOptions = [
    Home(),
    CareGiversList(),
    WishMessage(),
    ContactInfo(),
    Profile(),
  ];

  @override
  void onInit() async {
    userInfo = await helper.getStorage(Session.userInfo);
    if (userInfo != null) {
      print(userInfo['role']);
      if (userInfo['role'] == 'client') {
        print('Client data ********');
        widgetOptions = <Widget>[
          Home(),
          CareGiversList(),
          WishMessage(),
          ContactInfo(),
          Profile(),
        ];
      } else {
        widgetOptions = <Widget>[
          EmployeeHome(),
          PatientsList(),
          ContactInfo(),
          Profile(),
        ];
      }
      update();
    }
  }

  updateCurrentTab(int index) {
    // box.write('darkmode', true);
    _currentTab = index;
    update();
  }
}
