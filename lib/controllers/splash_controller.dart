import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(Duration(seconds: 2));

    // box.listen(() {
    //   print('box changed');
    //   print(box.read('darkmode'));
    // });
    // box.write('darkmode', false);

    // changeTheme(true);

    // print(box.read('darkmode'));
    print(helper.getStorage('authToken'));
    print('Token');
    final authToken = helper.getStorage('authToken');
    if (!helper.isNullOrBlank(authToken)) {
      print("Check");
      // Get.offAndToNamed(AppRouter.home);

      Get.offAndToNamed(routeName.bottomNavigationScreen);
    } else {
      checkLogin();
    }
    super.onInit();
  }

  void checkLogin() {
    Get.offAndToNamed(routeName.otpVerification);
  }
}
