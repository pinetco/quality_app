import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class RatingListController extends GetxController {
  List ratingList = [];

  @override
  void onReady() async {
    // TODO: implement onInit
    getRatingList();
    super.onReady();
  }

  getRatingList() async {
    helper.showLoading();
    apis.call(apiMethods.ratedDaysAPI, null, apiType.get).then((res) async {
      if (res.data != null && res.validation == false) {
        helper.hideLoading();
        final data = res.data['data'];
        print('Data, $data');
        ratingList = data;
        print('RatingList, $ratingList');
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
