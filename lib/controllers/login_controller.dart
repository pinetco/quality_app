import 'dart:async';

import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  String _isoCode;

  bool _rememberLogin = false;

  String get isoCode => _isoCode;

  bool get isRememberLogin => _rememberLogin;

  @override
  void onInit() async {
    // TODO: implement onInit
    tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    Loader().showLoading();
    await Future.delayed(Duration(seconds: 5));
    Loader().hideLoading();

    update();
    getPhoneNumber();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    txtMobile?.dispose();
    super.dispose();
  }

  void updateIsoCode(String isoCode) {
    _isoCode = isoCode;
    update();
  }

  void updateRememberLogin() {
    _rememberLogin = !_rememberLogin;

    update();
  }

  void getPhoneNumber() async {
    final SmsAutoFill _autoFill = SmsAutoFill();
    final completePhoneNumber = await _autoFill.hint;

    if (completePhoneNumber != null) {
      PhoneNumber numberRegionInfo = await PhoneNumber.getRegionInfoFromPhoneNumber(completePhoneNumber);
      txtMobile.text = int.parse(numberRegionInfo.parseNumber()).toString();
      _isoCode = numberRegionInfo.isoCode;
      update();
    }
  }

  void login() {
    Loader().showLoading();
    Timer(Duration(seconds: 1), () {
      Loader().hideLoading();
      Get.offAndToNamed(AppRouter.home);
      //Get.toNamed(AppRouter.bottomNavigationScreen);
    });
  }
}
