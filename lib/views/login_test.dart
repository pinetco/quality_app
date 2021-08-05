import 'package:quality_app/controllers/login_test_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';

class LoginTest extends StatelessWidget {
  var loginTestController = Get.put(LoginTestController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginTestController>(
      builder: (_) => Scaffold(
        backgroundColor: appColor.bgColor,
        body: LoadingComponent(
          //loading: loginController.isLoading,
          child: SingleChildScrollView(
            child: Container(
              height: appScreenUtil.screenActualHeight(),
              width: appScreenUtil.screenActualWidth(),
              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please Select User', style: appCss.bodyStyle3.copyWith(color: appColor.grayColor)),
                  SizedBox(height: appScreenUtil.size(40)),
                  InkWell(
                    onTap: () {
                      loginTestController.login('carePatient');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(appScreenUtil.size(100)),
                          border: Border.all(width: 1, color: appColor.deactivateColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(20)),
                          child: Image.asset(
                            imageAssets.carePatient,
                            width: appScreenUtil.size(100),
                            height: appScreenUtil.size(100),
                          ),
                        )),
                  ),
                  SizedBox(height: appScreenUtil.size(10)),
                  Text(
                    'Care Patient',
                    style: appCss.bodyStyle4,
                  ),
                  SizedBox(
                    height: appScreenUtil.size(70),
                  ),
                  InkWell(
                    onTap: () {
                      loginTestController.login('careGiver');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(appScreenUtil.size(100)),
                          border: Border.all(width: 1, color: appColor.deactivateColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(20)),
                          child: Image.asset(
                            imageAssets.careGiver,
                            width: appScreenUtil.size(100),
                            height: appScreenUtil.size(100),
                          ),
                        )),
                  ),
                  SizedBox(height: appScreenUtil.size(10)),
                  Text(
                    'Care Giver',
                    style: appCss.bodyStyle4,
                  ),
                  SizedBox(
                    height: appScreenUtil.size(70),
                  ),
                  CustomButton(
                    title: 'Try with another account',
                    onTap: () {
                      Get.toNamed(routeName.login);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
