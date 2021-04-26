import 'package:quality_app/controllers/login_test_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/utility/loading_component.dart';
import 'package:flutter/material.dart';

class LoginTest extends StatelessWidget {
  var loginTestController = Get.put(LoginTestController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginTestController>(
      builder: (_) => Scaffold(
        backgroundColor: bgColor,
        body: LoadingComponent(
          //loading: loginController.isLoading,
          child: SingleChildScrollView(
            child: Container(
              height: screenActualHeight(),
              width: screenActualWidth(),
              padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please Select User', style: bodyStyle3.copyWith(color: grayColor)),
                  SizedBox(height: screenHeight(40)),
                  InkWell(
                    onTap: () {
                      loginTestController.login('carePatient');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth(100)),
                          border: Border.all(width: 1, color: deactivateColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth(20)),
                          child: Image.asset(
                            carePatient,
                            width: screenWidth(100),
                            height: screenWidth(100),
                          ),
                        )),
                  ),
                  SizedBox(height: screenHeight(10)),
                  Text(
                    'Care Patient',
                    style: bodyStyle4,
                  ),
                  SizedBox(
                    height: screenHeight(70),
                  ),
                  InkWell(
                    onTap: () {
                      loginTestController.login('careGiver');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth(100)),
                          border: Border.all(width: 1, color: deactivateColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth(20)),
                          child: Image.asset(
                            careGiver,
                            width: screenWidth(100),
                            height: screenWidth(100),
                          ),
                        )),
                  ),
                  SizedBox(height: screenHeight(10)),
                  Text(
                    'Care Giver',
                    style: bodyStyle4,
                  ),
                  SizedBox(
                    height: screenHeight(70),
                  ),
                  CustomButton(
                    title: 'Try with another account',
                    onTap: () {
                      Get.toNamed(AppRouter.login);
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
