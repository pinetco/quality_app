import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/networking/server_config.dart';
import 'package:quality_app/global/packages/config_package.dart';
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

  changePassword() {
    Get.toNamed(routeName.changePassword);
  }

  // getData() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //      helper.showLoading();
  //       Apis.getApi(userAPI, []).then((res) async {
  //        helper.hideLoading();
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'Are you sure you want to logout?',
            style: appCss.bodyStyle4.copyWith(color: appColor.black22Color),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text('Cancel', style: appCss.bodyStyle6.copyWith(color: appColor.deactivateColor)),
                  onPressed: () {
                    Navigator.pop(Get.context);
                  },
                ),
                TextButton(
                  child: Text('Logout', style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor)),
                  onPressed: () {
                    helper.removeSpecificKeyStorage(session.authToken);
                    Navigator.pop(Get.context);
                    if (ServerConfig().apiType == 'development') {
                      Get.offAllNamed(routeName.login);
                      // Get.offAllNamed(routeName.loginTest);
                    } else {
                      // Get.offAllNamed(routeName.loginTest);
                      Get.offAllNamed(routeName.login);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
