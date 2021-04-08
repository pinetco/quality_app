import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:quality_app/packages/config_package.dart';

class SettingController extends GetxController with SingleGetTickerProviderMixin {
  dynamic userInfo;
  final _storageSettingCtrl = GetStorage();

  @override
  void onInit() {
    //getData();
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

  logout() {
    _showMyDialog();
  }

  // getData() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       Loader().showLoading();
  //       Apis.getApi(userAPI, []).then((res) async {
  //         Loader().hideLoading();
  //         if (res.StatusCode == 200) {
  //           final data = res.Data['data'];
  //           print(data);
  //           userInfo = data;
  //
  //           update();
  //         } else {}
  //       }, onError: (e) {
  //         print('e');
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     print('Socket');
  //   }
  // }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(Get.context);
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                _storageSettingCtrl.remove(Session.authToken);
                Navigator.pop(Get.context);
                Get.offAndToNamed(AppRouter.login);
              },
            ),
          ],
        );
      },
    );
  }
}
