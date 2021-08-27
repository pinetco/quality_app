import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    firebaseNotificationService.init(Get.context);
    final authToken = helper.getStorage('authToken');
    if (!helper.isNullOrBlank(authToken)) {
      Get.offAllNamed(routeName.bottomNavigationScreen);
    } else {
      checkLogin();
    }
    super.onReady();
  }

  void checkLogin() {
    Get.offAllNamed(routeName.loginTest);
  }
}
