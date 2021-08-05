import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/networking/api_methods.dart';

import 'common/loading_controller.dart';

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
  List questions = [];
  int lastIndex = 0;

  dynamic radioGroup = {};
  dynamic errors = [];
  dynamic surveyAnswers = [];

  @override
  void onInit() {
    getQuestions();
    super.onInit();
  }

  tapOnquestions(val, questionId, index) {
    questions[index]['survey_answer'] = val;
    update();
  }

  manageProgressBar() {
    final actualWidth = appScreenUtil.screenActualWidth() - appScreenUtil.size(48);
    final pWidth = actualWidth / totalStep;
    final activeWidth = activeStep * pWidth;
    return activeWidth;
  }

  nextStep() {
    validationQuestion();
  }

  validationQuestion() async {
    var currentStepQuestion = [];
    for (var i = 0; i < questions.length; i++) {
      currentStepQuestion.add({
        "survey_question_id": helper.jsonGet(questions[i], 'id', ''),
        "ratings": helper.jsonGet(questions[i], 'survey_answer', ''),
      });
    }
    var useQuestion = new List.from(surveyAnswers)..addAll(currentStepQuestion);

    final formData = {"page": activeStep, "survey_id": questions[0]['survey_id'], "survey_answers": useQuestion};

    helper.showLoading();
    apis.call(apiMethods.validationAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        errors = [];
        if (activeStep < totalStep) {
          activeStep = activeStep + 1;
        } else {
          submitAnswers();
          _showMyDialog();
        }

        surveyAnswers = new List.from(surveyAnswers)..addAll(currentStepQuestion);
        lastIndex = surveyAnswers.length;
        getQuestions();
      } else if (res.validation == true) {
        errors = res.data['errors'];
      }
      update();
    });
  }

  submitAnswers() {
    final formData = {"page": activeStep, "survey_id": questions[0]['survey_id'], "survey_answers": surveyAnswers};
    helper.showLoading();
    apis.call(apiMethods.surveyAnswerAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        errors = [];
        _showMyDialog();
      }
      update();
    });
  }

  getQuestions() async {
    helper.showLoading();
    apis.call(apiMethods.surveyQueAPI(activeStep), null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        totalStep = res.data['meta']['last_page'];
        // if (questions.length > 0) {
        //   var list = new List.from(questions)..addAll(data);
        //   questions = list;
        // } else {
        questions = data;
        //}

        update();
      } else {}
    }, onError: (e) {
      helper.hideLoading();
    });
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
                Get.offAndToNamed(routeName.home);
              },
            ),
          ],
        );
      },
    );
  }
}
