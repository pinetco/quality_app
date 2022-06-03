import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class SurveyStepController extends GetxController with SingleGetTickerProviderMixin {
  Map selected = new Map();

  int totalStep = 3;
  int activeStep = 1;
  dynamic progressBarWidth;
  List questions = [];
  int lastIndex = 0;

  dynamic radioGroup = {};
  dynamic errors = [];
  dynamic surveyAnswers = [];
  ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    print('Data');
    getQuestions();
    super.onReady();
  }

  tapOnquestions(val, questionId, index) {
    questions[index]['survey_answer'] = val;
    update();
  }

  manageProgressBar() {
    final actualWidth = appScreenUtil.screenActualWidth() - appScreenUtil.size(49);
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
    // print(currentStepQuestion);
    var useQuestion = new List.from(surveyAnswers)..addAll(currentStepQuestion);

    final formData = {"page": activeStep, "survey_id": questions[0]['survey_id'], "survey_answers": useQuestion};
    print('formData, $formData');

    helper.showLoading();
    apis.call(apiMethods.validationAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        errors = [];

        surveyAnswers = new List.from(surveyAnswers)..addAll(currentStepQuestion);
        lastIndex = surveyAnswers.length;
        if (activeStep == totalStep) {
          submitAnswers();
        } else {
          await Future.delayed(const Duration(milliseconds: 300));
          scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }

        if (activeStep < totalStep) {
          activeStep = activeStep + 1;
          getQuestions();
        }
        update();
      } else if (res.validation == true) {
        errors = res.data['errors'];
      }
      update();
    });
  }

  submitAnswers() {
    final formData = {"page": activeStep, "survey_id": questions[0]['survey_id'], "survey_answers": surveyAnswers};
    print("Print Data $formData");
    helper.showLoading();
    apis.call(apiMethods.surveyAnswerAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        errors = [];
        var homeClientCtrl = Get.find<HomeClientController>();
        homeClientCtrl.getSurveyList();
        _showMyDialog();
      }
      update();
    });
  }

  getQuestions() async {
    var data = Get.arguments;
    print(data);
    helper.showLoading();
    apis.call(apiMethods.surveyQueAPI(activeStep, data['id']), null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        totalStep = res.data['meta']['last_page'];
        questions = data;

        update();
      } else {}
    }, onError: (e) {
      helper.hideLoading();
    });
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
          title: Text(helper.trans('thank_you')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(helper.trans('survey_successfully_submitted')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(helper.trans('ok')),
              onPressed: () {
                Navigator.pop(Get.context!);
                var bottomCtrl = Get.find<BottomNavigationController>();
                bottomCtrl.updateCurrentTab(0);
                Get.toNamed(routeName.bottomNavigationScreen);
              },
            ),
          ],
        );
      },
    );
  }
}
