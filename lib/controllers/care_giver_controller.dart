import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/networking/index.dart';
import 'package:quality_app/global/packages/config_package.dart';

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
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.careGiverListAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
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
