import 'package:flutter/material.dart';
import 'package:quality_app/controllers/login_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/phone_number_with_country.dart';

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
                // print(val.phoneNumber);
                // print(val.dialCode);
                // print(val.isoCode);

                // print(loginController.txtMobile.text); // Text input value;
                loginController.updateIsoCode(val.isoCode, val.dialCode);
              },
              txtMobile: loginController.txtMobile,
              isoCode: loginController.isoCode,
            ),
          if (errorPhoneValidation != '') validationWidget(errorValidation: errorPhoneValidation),

          SizedBox(height: appScreenUtil.size(15)),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
            child: CustomTextFormField(
              container: loginController.txtPassword,
              // cursorColor: appColor.primaryColor,
              hintText: "Password",
              prefixIcon: Icon(MdiIcons.lock),
              suffixIcon: IconButton(
                icon: Icon(loginController.isObscureText == true ? MdiIcons.eye : MdiIcons.eyeOff, color: appColor.deactivateColor),
                onPressed: () {
                  loginController.togglePassword();
                },
              ),
              obscureText: loginController.isObscureText,
              style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
              keyboardType: TextInputType.text,
              padding: 18,
            ),
          ),
          if (errorPasswordValidation != '') validationWidget(errorValidation: errorPasswordValidation),

          SizedBox(height: appScreenUtil.size(5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => Scaffold(
        backgroundColor: appColor.bgColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   centerTitle: false,
        //   automaticallyImplyLeading: false,
        //   actions: [
        //     Center(
        //       child: InkWell(
        //         highlightColor: Colors.white,
        //         splashColor: Colors.transparent,
        //         onTap: () {
        //           Get.back();
        //           //bottomCtrl.updateCurrentTab(2);
        //         },
        //         child: Padding(
        //             padding: EdgeInsets.only(left: appScreenUtil.size(20.0)),
        //             child: Image.asset(
        //               imageAssets.backIcon,
        //               width: appScreenUtil.size(20),
        //             )),
        //       ),
        //     ),
        //     Spacer(),
        //   ],
        // ),
        body: LoadingComponent(
          //loading: loginController.isLoading,
          child: SingleChildScrollView(
            child: Container(
              height: appScreenUtil.screenActualHeight(),
              width: appScreenUtil.screenActualWidth(),
              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to', style: appCss.bodyStyle3.copyWith(color: appColor.grayColor)),
                  SizedBox(height: appScreenUtil.size(5)),
                  Text(
                    'Quality Control!',
                    style: appCss.h1,
                  ),
                  SizedBox(height: appScreenUtil.size(60)),
                  Form(
                    key: loginController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(size)(10)),
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
                          padding: EdgeInsets.only(top: appScreenUtil.size(8.0)),
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
                          padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(loginController.isRememberLogin == true ? MdiIcons.checkboxMarked : MdiIcons.checkboxBlankOutline, color: appColor.grayColor),
                                      Text(
                                        'Remember me',
                                        style: appCss.bodyStyle6,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    loginController.updateRememberLogin();
                                  }),
                              InkWell(
                                child: Text(
                                  'Forgot Password?',
                                  style: appCss.bodyStyle6,
                                ),
                                onTap: () {
                                  Get.toNamed(routeName.forgotPassword);
                                  // Navigator.pushNamed(context, AppRouter.forgotPassword);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: appScreenUtil.size(20)),
                        Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(10)),
                          child: CustomButton(
                            title: "Login",
                            // Working Progress not remove this line
                            // enable: loginController.txtEmail.text != true ? true : false,
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
        padding: EdgeInsets.only(top: appScreenUtil.size(8)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            errorValidation,
            style: appCss.validationTextStyle,
          ),
        ));
  }
}
