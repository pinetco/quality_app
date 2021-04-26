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
    if (!isRefreshing) Loader().showLoading();
    apis.getApi(patientsAPI, []).then((res) async {
      if (!isRefreshing) Loader().hideLoading();
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
    Get.toNamed(AppRouter.careGiverProfile, arguments: item);
  }
}
