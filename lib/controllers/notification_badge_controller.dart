import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NotificationBadgeController extends GetxController {
  int badgeCount = 0;
  void getBadgeCount() {
    helper.showLoading();
    apis.call(apiMethods.badgeCountAPI, null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res?.isSuccess == true) {
        badgeCount = res?.data['data']['count'];
        update();
      }
    });
  }
}
