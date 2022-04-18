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

    String languageCode = helper.getStorage(session.languageCode);
    String code = helper.getStorage(session.countryCode);
    this.languageCode = languageCode;
    changeLanguage(languageCode, code);
    print('languageCode, $languageCode');
    update();
    super.onReady();
  }

  void checkLogin() {
    // Get.offAllNamed(routeName.loginTest);
    Get.offAllNamed(routeName.login);
    // Get.offAllNamed(routeName.otpVerification);
  }

  void changeLanguage(language, code) {
    var locale = Locale(language, code);
    Get.updateLocale(locale);

    helper.writeStorage(session.languageCode, language);
    helper.writeStorage(session.countryCode, code);

    languageCode = language;
    update();

    Get.back();
  }
}
