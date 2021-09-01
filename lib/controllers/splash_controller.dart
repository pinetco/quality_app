import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
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
    super.onReady();
  }

  void checkLogin() {
    Get.offAllNamed(routeName.loginTest);
  }
}
