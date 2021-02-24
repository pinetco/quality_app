import 'package:quality_app/controllers/forgot_password_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/input_package.dart';

class ForgotPassword extends StatelessWidget {
  var forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Forgot Password', style: header.copyWith(color: primaryColor)),
      ),
      backgroundColor: bgColor,
      body: LoadingComponent(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(screenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Form(
                        key: forgotPasswordController.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight(50)),
                            CustomTextFormField(
                              container: forgotPasswordController.txtEmail,
                              hintText: "Email address",
                              prefixIcon: Icon(MdiIcons.email),
                              style: h4.copyWith(color: textSecondaryColor),
                              keyboardType: TextInputType.emailAddress,
                              padding: 20,
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'Please enter some value';
                                else
                                  return null;
                              },
                            ),
                            SizedBox(height: screenWidth(15)),
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
