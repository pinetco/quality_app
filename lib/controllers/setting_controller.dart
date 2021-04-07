import 'dart:io';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:quality_app/packages/config_package.dart';

class SettingController extends GetxController with SingleGetTickerProviderMixin {
  dynamic userInfo;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  navigationBack() {
    Get.back();
    //Get.offAll(AppRouter.home);
    // Navigator.pop(Get.context);
  }

  getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        Apis.getApi(userAPI, []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data['data'];
            print(data);
            userInfo = data;

            update();
          } else {}
        }, onError: (e) {
          print('e');
        });
      }
    } on SocketException catch (_) {
      print('Socket');
    }
  }
}
