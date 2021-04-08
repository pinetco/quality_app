import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

class SurveyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
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
                  padding: EdgeInsets.only(left: screenWidth(20.0)),
                  child: Image.asset(
                    backIcon,
                    width: screenWidth(20),
                  )),
            ),
          ),
          Spacer(),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('Survey', style: h1)),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                      child: Text(
                        'The following questions relate to specific aspects of the in-home services you receive from FirstLight Home Care.',
                        style: bodyStyle5.copyWith(color: black22Color),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth(10)),
                  child: CustomButton(
                    title: "Start",
                    onTap: () {
                      Get.toNamed(AppRouter.surveyStep);
                    },
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
