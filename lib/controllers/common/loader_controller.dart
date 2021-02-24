import 'package:get/get.dart';
import 'package:quality_app/packages/config_package.dart';

class LoaderController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void showLoading() {
    _isLoading = true;
    update();
  }

  void hideLoading() {
    _isLoading = false;
    update();
  }
}

class Loader {
  var loadingCtrl = Get.find<LoaderController>();

  void showLoading() => loadingCtrl.showLoading();

  void hideLoading() => loadingCtrl.hideLoading();
}
