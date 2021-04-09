import 'package:flutter/material.dart';
import 'package:quality_app/controllers/survey_step_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

class SurveyStep extends StatelessWidget {
  var surveyCtrl = Get.put(SurveyStepController());

  Widget myRadioButton(title, value, groupName, group) {
    return SizedBox(
      height: screenHeight(40),
      child: RadioListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(title, style: bodyStyle5.copyWith(color: grayColor)),
          value: value,
          groupValue: group,
          activeColor: primaryDarkColor,
          onChanged: (value) {
            surveyCtrl.tapOnquestions(groupName, value);
          }),
    );
    // return ListTile(
    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    //   title: Text(title, style: bodyStyle5.copyWith(color: grayColor)),
    //   contentPadding: EdgeInsets.all(0),
    //   leading: Radio<int>(
    //     activeColor: primaryDarkColor,
    //     value: value,
    //     groupValue: group,
    //     onChanged: (value) {
    //       surveyCtrl.tapOnquestions(value);
    //     },
    //   ),
    // );
  }

  Widget step1() {
    if (surveyCtrl.activeStep == 1)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step1groupVal1', surveyCtrl.step1groupVal1),
          myRadioButton('Disagree somewhat', 2, 'step1groupVal1', surveyCtrl.step1groupVal1),
          myRadioButton('Not sure', 3, 'step1groupVal1', surveyCtrl.step1groupVal1),
          myRadioButton('Agree somewhat', 4, 'step1groupVal1', surveyCtrl.step1groupVal1),
          myRadioButton('Agree strongly', 5, 'step1groupVal1', surveyCtrl.step1groupVal1),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step1groupVal2', surveyCtrl.step1groupVal2),
          myRadioButton('Disagree somewhat', 2, 'step1groupVal2', surveyCtrl.step1groupVal2),
          myRadioButton('Not sure', 3, 'step1groupVal2', surveyCtrl.step1groupVal2),
          myRadioButton('Agree somewhat', 4, 'step1groupVal2', surveyCtrl.step1groupVal2),
          myRadioButton('Agree strongly', 5, 'step1groupVal2', surveyCtrl.step1groupVal2),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step1groupVal3', surveyCtrl.step1groupVal3),
          myRadioButton('Disagree somewhat', 2, 'step1groupVal3', surveyCtrl.step1groupVal3),
          myRadioButton('Not sure', 3, 'step1groupVal3', surveyCtrl.step1groupVal3),
          myRadioButton('Agree somewhat', 4, 'step1groupVal3', surveyCtrl.step1groupVal3),
          myRadioButton('Agree strongly', 5, 'step1groupVal3', surveyCtrl.step1groupVal3),
          SizedBox(
            height: screenHeight(30),
          ),
        ],
      );
    return Container();
  }

  Widget step2() {
    if (surveyCtrl.activeStep == 2)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            'Test step 2',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step2groupVal1', surveyCtrl.step2groupVal1),
          myRadioButton('Disagree somewhat', 2, 'step2groupVal1', surveyCtrl.step2groupVal1),
          myRadioButton('Not sure', 3, 'step2groupVal1', surveyCtrl.step2groupVal1),
          myRadioButton('Agree somewhat', 4, 'step2groupVal1', surveyCtrl.step2groupVal1),
          myRadioButton('Agree strongly', 5, 'step2groupVal1', surveyCtrl.step2groupVal1),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step2groupVal2', surveyCtrl.step2groupVal2),
          myRadioButton('Disagree somewhat', 2, 'step2groupVal2', surveyCtrl.step2groupVal2),
          myRadioButton('Not sure', 3, 'step2groupVal2', surveyCtrl.step2groupVal2),
          myRadioButton('Agree somewhat', 4, 'step2groupVal2', surveyCtrl.step2groupVal2),
          myRadioButton('Agree strongly', 5, 'step2groupVal2', surveyCtrl.step2groupVal2),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step2groupVal3', surveyCtrl.step2groupVal3),
          myRadioButton('Disagree somewhat', 2, 'step2groupVal3', surveyCtrl.step2groupVal3),
          myRadioButton('Not sure', 3, 'step2groupVal3', surveyCtrl.step2groupVal3),
          myRadioButton('Agree somewhat', 4, 'step2groupVal3', surveyCtrl.step2groupVal3),
          myRadioButton('Agree strongly', 5, 'step2groupVal3', surveyCtrl.step2groupVal3),
        ],
      );
    return Container();
  }

  Widget step3() {
    if (surveyCtrl.activeStep == 3)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            'Test step 3',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step3groupVal1', surveyCtrl.step3groupVal1),
          myRadioButton('Disagree somewhat', 2, 'step3groupVal1', surveyCtrl.step3groupVal1),
          myRadioButton('Not sure', 3, 'step3groupVal1', surveyCtrl.step3groupVal1),
          myRadioButton('Agree somewhat', 4, 'step3groupVal1', surveyCtrl.step3groupVal1),
          myRadioButton('Agree strongly', 5, 'step3groupVal1', surveyCtrl.step3groupVal1),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step3groupVal2', surveyCtrl.step3groupVal2),
          myRadioButton('Disagree somewhat', 2, 'step3groupVal2', surveyCtrl.step3groupVal2),
          myRadioButton('Not sure', 3, 'step3groupVal2', surveyCtrl.step3groupVal2),
          myRadioButton('Agree somewhat', 4, 'step3groupVal2', surveyCtrl.step3groupVal2),
          myRadioButton('Agree strongly', 5, 'step3groupVal2', surveyCtrl.step3groupVal2),
          SizedBox(
            height: screenHeight(30),
          ),
          Container(
              child: Text(
            'The service I receive from FirstLight Home Care meets my expectations.',
            style: h5.copyWith(fontWeight: FontWeight.w500),
          )),
          myRadioButton('Disagree strongly', 1, 'step3groupVal3', surveyCtrl.step3groupVal3),
          myRadioButton('Disagree somewhat', 2, 'step3groupVal3', surveyCtrl.step3groupVal3),
          myRadioButton('Not sure', 3, 'step3groupVal3', surveyCtrl.step3groupVal3),
          myRadioButton('Agree somewhat', 4, 'step3groupVal3', surveyCtrl.step3groupVal3),
          myRadioButton('Agree strongly', 5, 'step3groupVal3', surveyCtrl.step3groupVal3),
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
          style: h1,
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
                  padding: EdgeInsets.only(right: screenWidth(20.0)),
                  child: Image.asset(
                    closeIcon,
                    width: screenWidth(16),
                  )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Survey', style: h1)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
                  height: screenHeight(16),
                  width: screenActualWidth(),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth(3)),
                        child: GetBuilder<SurveyStepController>(
                            builder: (_) => Container(
                                  width: surveyCtrl.manageProgressBar(),
                                  decoration: BoxDecoration(color: primaryDarkColor, borderRadius: BorderRadius.circular(screenWidth(10))),
                                )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(20),
                ),
                Expanded(
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: GetBuilder<SurveyStepController>(builder: (_) {
                        return Column(
                          children: [step1(), step2(), step3()],
                        );
                      }),
                    ),
                  ),
                ),

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
                        height: screenHeight(30),
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
                    padding: EdgeInsets.all(screenWidth(10)),
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
