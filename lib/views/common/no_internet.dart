import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NoInternetScreen extends StatelessWidget {
  void onRetry() async {
    bool isInternet = await helper.isNetworkConnection();
    if (isInternet) {
      String authToken = helper.getStorage(session.authToken);

      if (!helper.isNullOrBlank(authToken)) {
        Get.offAllNamed(routeName.login);
      } else {
        Get.offAllNamed(routeName.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        helper.dialogMessage(helper.trans('exit_confirmation'), onConfirm: () {
          SystemNavigator.pop();
        }, onCancel: () {});
        return false;
      },
      child: Scaffold(
        body: Container(
          color: appColor.primaryColor.withOpacity(0.1),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      helper.trans('check_internet_setting'),
                      textAlign: TextAlign.center,
                      style: appCss.h1,
                    ),
                    SizedBox(height: appScreenUtil.size(20)),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2, color: appColor.primaryColor),
                        padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(30)),
                      ),
                      onPressed: () => onRetry(),
                      child: Text(helper.trans('try_again'), style: appCss.h2.copyWith(color: appColor.primaryColor)),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: appScreenUtil.size(50),
                    width: appScreenUtil.screenActualWidth(),
                    decoration: BoxDecoration(
                      color: Color(0xFF8CACC1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(appScreenUtil.size(10)),
                        topLeft: Radius.circular(appScreenUtil.size(10)),
                      ),
                    ),
                  ),
                  // Image.asset(imageAssets.noInternet),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
