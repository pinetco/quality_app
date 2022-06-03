import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/networking/server_config.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController with SingleGetTickerProviderMixin {
  dynamic userInfo;
  @override
  void onInit() async {
    //getData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  navigationBack() {
    Get.back();
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            helper.trans('confirm_logout'),
            style: appCss.bodyStyle4.copyWith(color: appColor.black22Color),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text(helper.trans('cancel'), style: appCss.bodyStyle6.copyWith(color: appColor.deactivateColor)),
                  onPressed: () {
                    Navigator.pop(Get.context!);
                  },
                ),
                TextButton(
                  child: Text(helper.trans('logout'), style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor)),
                  onPressed: () {
                    helper.removeSpecificKeyStorage(session.authToken);
                    Navigator.pop(Get.context!);
                    if (ServerConfig().apiType == 'development') {
                      Get.offAllNamed(routeName.login);
                      // Get.offAllNamed(routeName.loginTest); // do not remove
                    } else {
                      // Get.offAllNamed(routeName.loginTest); // do not remove
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
