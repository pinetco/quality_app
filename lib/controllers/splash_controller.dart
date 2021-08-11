import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(Duration(seconds: 2));

    firebaseNotificationService.init(Get.context);

    print(helper.getStorage('authToken'));
    print('Token');
    final authToken = helper.getStorage('authToken');
    if (!helper.isNullOrBlank(authToken)) {
      Get.offAndToNamed(routeName.bottomNavigationScreen);
    } else {
      checkLogin();
    }
    super.onInit();
  }

  void checkLogin() {
    Get.offAndToNamed(routeName.loginTest);
  }
}
