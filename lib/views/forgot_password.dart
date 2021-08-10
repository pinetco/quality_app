import 'package:quality_app/controllers/forgot_password_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/global/widgets/phone_number_with_country.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {
  var forgotPasswordCtrl = Get.put(ForgotPasswordController());

  Widget validationWidget(errorValidation) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              child: Icon(MdiIcons.arrowLeft, color: appColor.black22Color),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        body: GetBuilder<ForgotPasswordController>(builder: (_) {
          dynamic errorPhoneValidation = forgotPasswordCtrl.phoneFieldError ?? '';
          print('errorPhoneValidation, $errorPhoneValidation');
          return LoadingComponent(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forgot Password',
                            style: appCss.h1,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: appScreenUtil.size(15)),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhoneNumberWithCountry(
                            onInputChanged: (val) async {
                              forgotPasswordCtrl.updateIsoCode(val.isoCode, val.dialCode);
                            },
                            txtMobile: forgotPasswordCtrl.txtMobile,
                            isoCode: forgotPasswordCtrl.isoCode,
                          ),
                          if (errorPhoneValidation != '') validationWidget(errorPhoneValidation),
                        ],
                      ),
                    ),
                    SizedBox(height: appScreenUtil.size(30)),
                    CustomButton(
                      title: 'Submit',
                      onTap: () {
                        forgotPasswordCtrl.forgotPasssword();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
