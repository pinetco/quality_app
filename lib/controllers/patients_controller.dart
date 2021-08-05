import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class PatientsController extends GetxController with SingleGetTickerProviderMixin {
  List patientsList = [];
  bool isRefreshing = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    // TODO: implement onInit
    getPatientsList();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getPatientsList() async {
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.patientsAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];

        patientsList = data;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getPatientsList();
    return null;
  }

  navigateOtherProfile(item) {
    Get.toNamed(routeName.careGiverProfile, arguments: item);
  }
}
