import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NotificationBadgeController extends GetxController {
  int badgeCount = 0;
  void getBadgeCount() {
    helper.showLoading();
    apis.call(apiMethods.badgeCountAPI, null, apiType.get).then((resData) async {
      helper.hideLoading();
      if (resData?.isSuccess == true) {
        badgeCount = resData?.data['data']['count'];
        update();
      }
    });
  }
}
