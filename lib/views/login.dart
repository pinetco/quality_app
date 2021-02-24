import 'dart:async';
import 'dart:ui' as ui;

import 'package:quality_app/controllers/login_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/utility/loading_component.dart';
import 'package:quality_app/widgets/phone_number_with_country.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  var loginController = Get.put(LoginController());

  Widget emailMobileWidget(String loginOption) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // if (loginOption == "email")
          //   CustomTextFormField(
          //     container: loginController.txtEmail,
          //     hintText: "Email address",
          //     prefixIcon: Icon(MdiIcons.email),
          //     style: h4,
          //     keyboardType: TextInputType.emailAddress,
          //     padding: 20,
          //     validator: (val) {
          //       if (val.isEmpty)
          //         return 'Please enter some value';
          //       else
          //         return null;
          //     },
          //   ),
          if (loginOption == "mobile")
            PhoneNumberWithCountry(
                onInputChanged: (val) async {
                  print(val.phoneNumber);
                  print(val.dialCode);
                  print(val.isoCode);

                  print(loginController.txtMobile.text); // Text input value;
                  loginController.updateIsoCode(val.isoCode);
                },
                txtMobile: loginController.txtMobile,
                isoCode: loginController.isoCode),
          SizedBox(height: screenHeight(15)),
          CustomTextFormField(
            container: loginController.txtPassword,
            hintText: "Password",
            prefixIcon: Icon(MdiIcons.lock),
            obscureText: true,
            style: h4.merge(ls1),
            keyboardType: TextInputType.text,
            padding: 20,
            validator: (val) {
              if (val.isEmpty)
                return 'Please enter some value';
              else
                return null;
            },
          ),
          SizedBox(height: screenHeight(5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => Scaffold(
        backgroundColor: bgColor,
        body: LoadingComponent(
          //loading: loginController.isLoading,
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  height: screenActualHeight(),
                  width: screenActualWidth(),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Quality App',
                              style: h1.copyWith(fontSize: screenWidth(28)),
                            ),
                            SizedBox(height: screenHeight(10)),
                            Text(
                              'Health Sector Quality checker',
                              style: h4,
                            ),
                            SizedBox(height: screenHeight(100)),
                            Form(
                              key: loginController.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                                  //   child: TabBar(
                                  //     controller: loginController.tabController,
                                  //     indicatorColor: primaryColor,
                                  //     labelColor: primaryColor,
                                  //     unselectedLabelColor: Colors.black54,
                                  //     onTap: (val) {
                                  //       FocusScopeNode currentFocus = FocusScope.of(context);
                                  //
                                  //       if (!currentFocus.hasPrimaryFocus) {
                                  //         currentFocus.unfocus();
                                  //       }
                                  //     },
                                  //     // isScrollable: true,
                                  //     tabs: <Widget>[
                                  //       Tab(
                                  //         text: "Mobile",
                                  //       ),
                                  //       Tab(
                                  //         text: "Email",
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: screenHeight(160),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: screenWidth(8.0)),
                                      child: emailMobileWidget('mobile'),

                                      // TabBarView(controller: loginController.tabController,
                                      //     // Restrict scroll by user
                                      //     // physics: const NeverScrollableScrollPhysics(),
                                      //     children: [
                                      //       // Sign In View
                                      //       emailMobileWidget('mobile'),
                                      //       // Sign Up View
                                      //       emailMobileWidget('email'),
                                      //     ]),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(loginController.isRememberLogin == true ? MdiIcons.checkboxMarked : MdiIcons.checkboxBlankOutline,
                                                    color: textPrimaryColor),
                                                Text(
                                                  'Remember Login',
                                                  style: h5.copyWith(color: textPrimaryColor),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              loginController.updateRememberLogin();
                                            }),
                                        InkWell(
                                          child: Text(
                                            'Forgot Password?',
                                            style: h5.copyWith(color: textPrimaryColor),
                                          ),
                                          onTap: () {
                                            Get.toNamed(AppRouter.forgotPassword);
                                            // Navigator.pushNamed(context, AppRouter.forgotPassword);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight(20)),
                                  Padding(
                                    padding: EdgeInsets.all(screenWidth(10)),
                                    child: CustomButton(
                                      title: "Login",
                                      padding: screenWidth(20),
                                      onTap: () {
                                        loginController.login();
                                      },
                                    ),
                                  ),
                                ],
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
          }),
        ),
      ),
    );
  }
}
