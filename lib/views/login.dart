import 'package:quality_app/controllers/login_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/utility/loading_component.dart';
import 'package:quality_app/widgets/phone_number_with_country.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  var loginController = Get.put(LoginController());

  Widget emailMobileWidget(String loginOption) {
    dynamic errorPhoneValidation = loginController.phoneFieldError ?? '';
    dynamic errorPasswordValidation = loginController.passwordFieldError ?? '';
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
                loginController.updateIsoCode(val.isoCode, val.dialCode);
              },
              txtMobile: loginController.txtMobile,
              isoCode: loginController.isoCode,
            ),
          if (errorPhoneValidation != '') validationWidget(errorValidation: errorPhoneValidation),

          SizedBox(height: screenHeight(15)),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
            child: CustomTextFormField(
              container: loginController.txtPassword,
              hintText: "Password",
              prefixIcon: Icon(MdiIcons.lock),
              suffixIcon: IconButton(
                icon: Icon(loginController.isObscureText == true ? MdiIcons.eye : MdiIcons.eyeOff, color: deactivateColor),
                onPressed: () {
                  loginController.togglePassword();
                },
              ),
              obscureText: loginController.isObscureText,
              style: bodyStyle5,
              keyboardType: TextInputType.text,
              padding: 18,
            ),
          ),
          if (errorPasswordValidation != '') validationWidget(errorValidation: errorPasswordValidation),

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
          child: SingleChildScrollView(
            child: Container(
              height: screenActualHeight(),
              width: screenActualWidth(),
              padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to', style: bodyStyle3.copyWith(color: grayColor)),
                  SizedBox(height: screenHeight(5)),
                  Text(
                    'Quality Control!',
                    style: h1,
                  ),
                  SizedBox(height: screenHeight(60)),
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
                        Padding(
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
                                          color: black22Color),
                                      Text(
                                        'Remember me',
                                        style: bodyStyle5.copyWith(color: black22Color),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    loginController.updateRememberLogin();
                                  }),
                              // InkWell(
                              //   child: Text(
                              //     'Forgot Password?',
                              //     style: h5.copyWith(color: textPrimaryColor),
                              //   ),
                              //   onTap: () {
                              //     Get.toNamed(AppRouter.forgotPassword);
                              //     // Navigator.pushNamed(context, AppRouter.forgotPassword);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight(20)),
                        Padding(
                          padding: EdgeInsets.all(screenWidth(10)),
                          child: CustomButton(
                            title: "Login",
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
          ),
        ),
      ),
    );
  }
}

class validationWidget extends StatelessWidget {
  const validationWidget({
    Key key,
    @required this.errorValidation,
  }) : super(key: key);

  final String errorValidation;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: screenWidth(8)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            errorValidation,
            style: validationTextStyle,
          ),
        ));
  }
}
