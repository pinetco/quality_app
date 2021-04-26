import 'dart:convert';

import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

class LoginTestController extends GetxController with SingleGetTickerProviderMixin {
  void login(type) async {
    final formData = {
      'phone': type == 'careGiver' ? '+4213125824948' : '+3792716066206',
      'password': 'password',
    };

    print(formData);

    Loader().showLoading();

    apis.postApi(loginAPI, formData).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        helper.writeStorage(Session.authToken, data['token']);

        getUserInfo();
      }
    }, onError: (e) {
      Loader().hideLoading();
    });
  }

  getUserInfo() async {
    Loader().showLoading();
    apis.getApi(userAPI, []).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];

        await helper.writeStorage(Session.userInfo, data);
        update();
        Get.offAndToNamed(AppRouter.bottomNavigationScreen);
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
