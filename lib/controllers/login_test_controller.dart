import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class LoginTestController extends GetxController with SingleGetTickerProviderMixin {
  void login(type) async {
    final formData = {
      'phone': type == 'careGiver' ? '+4213125824948' : '+3792716066206',
      'password': 'password',
    };
    print(formData);
    helper.showLoading();
    apis.call(apiMethods.loginAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        helper.writeStorage(session.authToken, data['token']);

        getUserInfo();
      }
    }, onError: (e) {
      helper.hideLoading();
    });
  }

  getUserInfo() async {
    helper.showLoading();
    apis.call(apiMethods.userAPI, null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];

        await helper.writeStorage(session.userInfo, data);
        update();
        Get.offAndToNamed(routeName.bottomNavigationScreen);
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
