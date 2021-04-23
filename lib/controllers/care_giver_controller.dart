import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forceupdate/forceupdate.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

import 'common/loader_controller.dart';

class CareGiverController extends GetxController with SingleGetTickerProviderMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List careGiverList = [];
  bool isRefreshing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    // wait untill widget load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    getCareGivers();
    // });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getCareGivers() async {
    if (!isRefreshing) Loader().showLoading();
    apis.getApi(careGiverListAPI, []).then((res) async {
      if (!isRefreshing) Loader().hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        careGiverList = data;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getCareGivers();
    return null;
  }
}
