import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NotificationController extends GetxController {
  var label = "";
  List notificationList = [];
  bool isRefreshing = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(const Duration(seconds: 2));
    getNotificationList();
    super.onInit();
  }

  getNotificationList() async {
    helper.showLoading();
    apis.call(apiMethods.notificationsAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        print('data,$data');
        notificationList = data;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
