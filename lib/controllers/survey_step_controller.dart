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

class SurveyStepController extends GetxController with SingleGetTickerProviderMixin {
  Map selected = new Map();

  int step1groupVal1 = 1;
  int step1groupVal2 = 1;
  int step1groupVal3 = 1;

  int step2groupVal1 = 1;
  int step2groupVal2 = 1;
  int step2groupVal3 = 1;

  int step3groupVal1 = 1;
  int step3groupVal2 = 1;
  int step3groupVal3 = 1;

  int groupVal2 = 2;
  int groupVal3 = 3;
  int totalStep = 3;
  int activeStep = 1;
  dynamic progressBarWidth;
  dynamic questions;

  @override
  void onInit() {
    getQuestions();
    super.onInit();
  }

  tapOnquestions(groupName, val) {
    if (groupName == 'step1groupVal1') step1groupVal1 = val;
    if (groupName == 'step1groupVal2') step1groupVal2 = val;
    if (groupName == 'step1groupVal3') step1groupVal3 = val;

    if (groupName == 'step2groupVal1') step2groupVal1 = val;
    if (groupName == 'step2groupVal2') step2groupVal2 = val;
    if (groupName == 'step2groupVal3') step2groupVal3 = val;

    if (groupName == 'step3groupVal1') step3groupVal1 = val;
    if (groupName == 'step3groupVal2') step3groupVal2 = val;
    if (groupName == 'step3groupVal3') step3groupVal3 = val;

    update();
  }

  manageProgressBar() {
    final actualWidth = screenActualWidth() - screenWidth(48);
    final pWidth = actualWidth / totalStep;

    final activeWidth = activeStep * pWidth;
    return activeWidth;
  }

  nextStep() {
    if (activeStep < totalStep) {
      activeStep = activeStep + 1;
      update();
    } else {
      _showMyDialog();
    }
  }

  getQuestions() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        Apis.getApi(surveyQueAPI, []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data;

            questions = data['data'];

            update();
          } else {}
        }, onError: (e) {
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your survey has been successfully submitted'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(Get.context);
                Get.offAndToNamed(AppRouter.home);
              },
            ),
          ],
        );
      },
    );
  }
}
