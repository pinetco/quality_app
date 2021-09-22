import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class RequestListController extends GetxController {
  // List requestList = [
  //   {'name': 'Joe Belfiore', 'date': '21-9-2021'},
  //   {'name': 'Bill Gates', 'date': '21-9-2021'},
  //   {'name': 'Marissa Mayer', 'date': '21-9-2021'},
  // ];

  List requestList = [];

  @override
  void onReady() async {
    // TODO: implement onInit
    getRatingList();
    super.onReady();
  }

  getRatingList() async {
    helper.showLoading();
    apis.call(apiMethods.requestsAPI, null, apiType.get).then((res) async {
      if (res.data != null && res.validation == false) {
        helper.hideLoading();
        final data = res.data['data'];
        print('Data, $data');
        requestList = data;
        print('RatingList, $requestList');
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
