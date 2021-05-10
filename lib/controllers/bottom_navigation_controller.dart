import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:quality_app/networking/api_methods.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/screen_package.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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
      if (userInfo['role'] == 'client') {
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
      getTokenRegister();
      update();
    }
  }

  getTokenRegister() async {
    String name;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      name = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      name = iosInfo.name;
    }

    final formData = {
      'token': helper.getStorage(Session.fcmToken),
      'type': Platform.isAndroid ? 'android' : 'ios',
      'os_version': Platform.operatingSystemVersion,
      'name': name,
    };

    apis.postApi(registerTokenAPI, formData).then((res) async {
      Loader().hideLoading();
      print(res.data);
      if (res.data != null && res.validation == false) {
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  updateCurrentTab(int index) {
    // box.write('darkmode', true);
    _currentTab = index;
    update();
  }
}
