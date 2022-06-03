import 'package:flutter/material.dart';
import 'package:quality_app/controllers/login/login_controller.dart';
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
          if (loginOption == "mobile")
            PhoneNumberWithCountry(
              onInputChanged: (val) async {
                loginController.updateIsoCode(val.isoCode!, val.dialCode!);
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
              hintText: helper.trans('password'),
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
                  Text(helper.trans('welcome_to'), style: appCss.bodyStyle3.copyWith(color: appColor.grayColor)),
                  SizedBox(height: appScreenUtil.size(5)),
                  Text(
                    helper.trans('quality_control'),
                    style: appCss.h1,
                  ),
                  SizedBox(height: appScreenUtil.size(60)),
                  Form(
                    key: loginController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: appScreenUtil.size(8.0)),
                          child: emailMobileWidget('mobile'),
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
                                        helper.trans('remember_me'),
                                        style: appCss.bodyStyle6,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    loginController.updateRememberLogin();
                                  }),
                              InkWell(
                                child: Text(
                                  helper.trans('forgot_password') + '?',
                                  style: appCss.bodyStyle6,
                                ),
                                onTap: () {
                                  Get.toNamed(routeName.forgotPassword);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: appScreenUtil.size(20)),
                        Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(10)),
                          child: CustomButton(
                            title: helper.trans('login'),
                            // Working Progress not remove this line
                            // enable: loginController.txtEmail.text != true ? true : false,
                            onTap: () {
                              loginController.login();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(10)),
                          child: CustomButton(
                            title: helper.trans('activate_account'),
                            color: appColor.whiteColor,
                            border: Border.all(color: appColor.primaryColor),
                            style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
                            onTap: () {
                              Get.toNamed(routeName.forgotPassword);
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
    Key? key,
    @required this.errorValidation,
  }) : super(key: key);

  final String? errorValidation;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: appScreenUtil.size(8)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            errorValidation!,
            style: appCss.validationTextStyle,
          ),
        ));
  }
}
