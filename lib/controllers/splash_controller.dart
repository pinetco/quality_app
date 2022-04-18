import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
  String languageCode = '';
  @override
  void onReady() async {
    await Future.delayed(Duration(seconds: 3));
    firebaseNotificationService.init(Get.context);
    final authToken = helper.getStorage('authToken');
    if (!helper.isNullOrBlank(authToken)) {
      Get.offAllNamed(routeName.bottomNavigationScreen);
    } else {
      checkLogin();
    }
    final String defaultLocale = Platform.localeName; // Not tested yet
    print('defaultLocale, $defaultLocale');

    String languageCode = helper.getStorage(session.languageCode);
    String code = helper.getStorage(session.countryCode);
    if (helper.isNullOrBlank(languageCode)) {
      languageCode = defaultLocale; // Not tested yet
      code = defaultLocale; // Not tested yet
    }
    print('languageCode, $languageCode');
    this.languageCode = languageCode;
    changeLanguage(languageCode, code);
    update();
    super.onReady();
  }

  void checkLogin() {
    // Get.offAllNamed(routeName.loginTest);
    Get.offAllNamed(routeName.login);
    // Get.offAllNamed(routeName.otpVerification);
  }

  void changeLanguage(language, code) {
    print('language, $language');
    print('code,$code');
    var locale = Locale(language, code);
    Get.updateLocale(locale);

    helper.writeStorage(session.languageCode, language);
    helper.writeStorage(session.countryCode, code);

    languageCode = language;
    update();

    Get.back();
  }
}
