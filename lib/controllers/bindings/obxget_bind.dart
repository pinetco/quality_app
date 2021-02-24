import 'package:get/get.dart';
import 'package:quality_app/controllers/obx_getx_controller.dart';

class ObxGetxBind extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ObxGetxController>(() => ObxGetxController());
  }
}
