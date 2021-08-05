import 'package:quality_app/controllers/forgot_password_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  var forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        title: Text('Forgot Password'), //style: header.copyWith(color: primaryColor)
      ),
      backgroundColor: appColor.bgColor,
      body: LoadingComponent(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(appScreenUtil.size(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Form(
                        key: forgotPasswordController.formForgotKey,
                        child: Column(
                          children: [
                            SizedBox(height: appScreenUtil.size(50)),
                            CustomTextFormField(
                              container: forgotPasswordController.txtEmail,
                              hintText: "Email address",
                              prefixIcon: Icon(MdiIcons.email),
                              style: appCss.h4.copyWith(color: appColor.textSecondaryColor),
                              keyboardType: TextInputType.emailAddress,
                              padding: 20,
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'Please enter some value';
                                else
                                  return null;
                              },
                            ),
                            SizedBox(height: appScreenUtil.size(15)),
                            CustomButton(
                              title: "Submit",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
