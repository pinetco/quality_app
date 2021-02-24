import 'package:get/get.dart';
import 'package:quality_app/controllers/account_controller.dart';
import 'package:quality_app/controllers/splash_controller.dart';

class SplashBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
