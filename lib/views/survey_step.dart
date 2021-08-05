import 'package:flutter/material.dart';
import 'package:quality_app/controllers/survey_step_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';

class SurveyStep extends StatelessWidget {
  var surveyCtrl = Get.put(SurveyStepController());

  Widget myRadioButton(label, value, group, index) {
    return SizedBox(
      height: appScreenUtil.size(40),
      child: RadioListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(label, style: appCss.bodyStyle5.copyWith(color: appColor.grayColor)),
          value: value,
          groupValue: group,
          activeColor: appColor.primaryDarkColor,
          onChanged: (value) {
            surveyCtrl.tapOnquestions(value, group, index);
          }),
    );
  }

  Widget renderQuestionList(item, index) {
    String title = helper.jsonGet(item, 'question.title', '');
    dynamic activeIndex = surveyCtrl.lastIndex + index;
    dynamic error = !helper.isNullOrBlank(surveyCtrl.errors) ? helper.getErrorKey(surveyCtrl.errors, 'survey_answers', activeIndex, 'ratings') : '';
    dynamic group = item['survey_answer'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Text(
          title,
          style: appCss.h5.copyWith(fontWeight: FontWeight.w500),
        )),
        myRadioButton('Disagree strongly', 1, group, index),
        myRadioButton('Disagree somewhat', 2, group, index),
        myRadioButton('Not sure', 3, group, index),
        myRadioButton('Agree somewhat', 4, group, index),
        myRadioButton('Agree strongly', 5, group, index),
        SizedBox(
          height: appScreenUtil.size(10),
        ),
        if (error != '') Text('$error', style: appCss.bodyStyle6.copyWith(color: Colors.red)),
        SizedBox(
          height: appScreenUtil.size(20),
        ),
      ],
    );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Survey',
          style: appCss.h1,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
                //bottomCtrl.updateCurrentTab(2);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: appScreenUtil.size(20.0)),
                  child: Image.asset(
                    imageAssets.closeIcon,
                    width: appScreenUtil.size(16),
                  )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Survey', style: h1)),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
                  height: appScreenUtil.size(16),
                  width: appScreenUtil.screenActualWidth(),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(appScreenUtil.size(3)),
                        child: GetBuilder<SurveyStepController>(
                            builder: (_) => Container(
                                  width: surveyCtrl.manageProgressBar(),
                                  decoration: BoxDecoration(color: appColor.primaryDarkColor, borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
                                )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: appScreenUtil.size(20),
                ),
                GetBuilder<SurveyStepController>(builder: (_) {
                  if (surveyCtrl.questions != null && surveyCtrl.questions.length > 0)
                    return Expanded(
                      child: ListView.builder(
                        itemCount: surveyCtrl.questions.length,
                        itemBuilder: (context, index) {
                          dynamic item = surveyCtrl.questions[index];
                          return renderQuestionList(item, index);
                        },
                      ),
                    );
                  return Expanded(child: Container());
                }),
                /* Expanded(
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: GetBuilder<SurveyStepController>(builder: (_) {
                        return Column(
                          children: [step1(), step2(), step3()],
                        );
                      }),
                    ),
                  ),
                ),*/

                /*   GetBuilder<SurveyStepController>(builder: (_) {
                  return Column(
                    children: [
                      Container(
                          child: Text(
                        'The service I receive from FirstLight Home Care meets my expectations.',
                        style: h5.copyWith(fontWeight: FontWeight.w500),
                      )),
                      myRadioButton('Disagree strongly', 1, surveyCtrl.groupVal),
                      myRadioButton('Disagree somewhat', 2, surveyCtrl.groupVal),
                      myRadioButton('Not sure', 3, surveyCtrl.groupVal),
                      myRadioButton('Agree somewhat', 4, surveyCtrl.groupVal),
                      myRadioButton('Agree strongly', 5, surveyCtrl.groupVal),
                      SizedBox(
                        height: appScreenUtil.size(size)(30),
                      ),
                      Container(
                          child: Text(
                        'The service I receive from FirstLight Home Care meets my expectations.',
                        style: h5.copyWith(fontWeight: FontWeight.w500),
                      )),
                      myRadioButton('Disagree strongly', 1, surveyCtrl.groupVal),
                      myRadioButton('Disagree somewhat', 2, surveyCtrl.groupVal),
                      myRadioButton('Not sure', 3, surveyCtrl.groupVal),
                      myRadioButton('Agree somewhat', 4, surveyCtrl.groupVal),
                      myRadioButton('Agree strongly', 5, surveyCtrl.groupVal),
                    ],
                  );
                }),*/
                GetBuilder<SurveyStepController>(
                  builder: (_) => Padding(
                    padding: EdgeInsets.all(appScreenUtil.size(10)),
                    child: CustomButton(
                      title: surveyCtrl.activeStep == surveyCtrl.totalStep ? 'Submit' : "Next",
                      onTap: () {
                        surveyCtrl.nextStep();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
