import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    // TODO: implement onInit
    // await Future.delayed(Duration(seconds: 10));
    //
    firebaseNotificationService.init(Get.context);

    print(helper.getStorage('authToken'));
    print('Token');
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
