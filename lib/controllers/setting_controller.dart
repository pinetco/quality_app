import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/networking/server_config.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController with SingleGetTickerProviderMixin {
  dynamic userInfo;
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

  openURL(val, type) {
    if (type == 'phone') {
      launch("tel://$val");
    }
    if (type == 'email') {
      final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: val, queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});
      launch(_emailLaunchUri.toString());
    }
  }

  openURLContactInfo(val, type) async {
    if (type == 'phone') {
      launch("tel://$val");
    }
    if (type == 'email') {
      final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: val, queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});
      launch(_emailLaunchUri.toString());
    }

    if (type == 'website') {
      await launch(val);
    }
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
          title: Text('Are you sure you want to logout?', style: bodyStyle4.copyWith(color: black22Color)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: bodyStyle6.copyWith(color: deactivateColor)),
              onPressed: () {
                Navigator.pop(Get.context);
              },
            ),
            TextButton(
              child: Text('Logout', style: bodyStyle6.copyWith(color: primaryDarkColor)),
              onPressed: () {
                helper.removeSpecificKeyStorage(Session.authToken);
                Navigator.pop(Get.context);
                if (ServerConfig().apiType == 'development') {
                  Get.offAndToNamed(AppRouter.loginTest);
                } else {
                  Get.offAndToNamed(AppRouter.login);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
