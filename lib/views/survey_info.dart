import 'package:flutter/material.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';

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
                  padding: EdgeInsets.only(left: appScreenUtil.size(20.0)),
                  child: Image.asset(
                    imageAssets.backIcon,
                    width: appScreenUtil.size(20),
                  )),
            ),
          ),
          Spacer(),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('Survey', style: appCss.h1)),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                      child: Text(
                        'The following questions relate to specific aspects of the in-home services you receive from FirstLight Home Care.',
                        style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(appScreenUtil.size(10)),
                  child: CustomButton(
                    title: "Start",
                    onTap: () {
                      final data = Get.arguments;
                      Get.toNamed(routeName.surveyStep, arguments: {'id': data['id']});
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
