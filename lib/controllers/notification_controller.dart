import 'package:get/get.dart';
import 'package:quality_app/controllers/notification_badge_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NotificationController extends GetxController {
  var label = "";
  List notificationList = [];
  bool isRefreshing = false;

  @override
  void onReady() async {
    // TODO: implement onInit
    getNotificationList();
    var notificationBadgeCtrl = Get.find<NotificationBadgeController>();
    notificationBadgeCtrl.getBadgeCount();
    super.onReady();
  }

  getNotificationList() async {
    helper.showLoading();
    apis.call(apiMethods.notificationsAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        print('Data, $data');
        notificationList = data;
        print('notificationList, $notificationList');
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  // AcceptedRequestData function
  void acceptedRequest(id) async {
    helper.showLoading();
    apis.call(apiMethods.acceptedRequestAPI(id), null, apiType.put).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        print(res.data);
        getNotificationList();
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  // RejectedRequest function
  void rejectRequest(id) async {
    print('id, $id');
    helper.showLoading();
    apis.call(apiMethods.rejectRequestAPI(id), null, apiType.put).then((res) async {
      print("Rejected Function Fire, $res");
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        print(res.data);
        getNotificationList();
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  // Rate buttton function
  void rateReview() {
    Get.toNamed(routeName.reviewSubmission);
  }
}
