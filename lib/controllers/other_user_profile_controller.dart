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

class OtherUserProfileController extends GetxController with SingleGetTickerProviderMixin {
  List patientsList = [];
  dynamic userDetails;

  @override
  void onInit() {
    // TODO: implement onInit
    var data = Get.arguments;
    userDetails = data;
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
}
