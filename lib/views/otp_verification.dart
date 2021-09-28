import 'package:flutter/material.dart';
import 'package:quality_app/controllers/otp_verification_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

// ignore: must_be_immutable
class OTPVerification extends StatelessWidget {
  var otpVerificationCtrl = Get.put(OTPVerificationController());

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
        body: GetBuilder<OTPVerificationController>(builder: (_dx) {
          return LoadingComponent(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
                  child: Column(children: [
                    Image.asset(imageAssets.otpImage),
                    Container(
                      child: Text(
                        _dx.tokenError,
                        style: appCss.validationTextStyle,
                      ),
                    ),
                    Container(
                      child: Text(
                        _dx.phoneFieldError,
                        style: appCss.validationTextStyle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Phone Number Verification',
                        style: appCss.h5,
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(height: appScreenUtil.size(15)),
                    RichText(
                      text: TextSpan(
                        text: 'Enter the code sent to ',
                        style: appCss.bodyStyle6,
                        children: <TextSpan>[
                          TextSpan(text: _dx.phone, style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: appScreenUtil.size(15)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(30)),
                      child: PinFieldAutoFill(
                        autofocus: true,
                        codeLength: 4,
                        decoration: UnderlineDecoration(
                          textStyle: TextStyle(fontSize: appScreenUtil.size(20), color: Colors.black),
                          colorBuilder: FixedColorBuilder(appColor.primaryColor),
                        ),
                        currentCode: otpVerificationCtrl.code,
                        onCodeSubmitted: (code) {
                          _dx.loginWithToken();
                        },
                        onCodeChanged: (code) {
                          otpVerificationCtrl.code = code;
                          if (code.length == 4) {
                            _dx.loginWithToken();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: appScreenUtil.size(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: appCss.bodyStyle6,
                        ),
                        SizedBox(
                          width: appScreenUtil.size(10),
                        ),
                        InkWell(
                          onTap: () {
                            otpVerificationCtrl.otpSent();
                          },
                          child: Text(
                            'RESEND',
                            style: appCss.h5.copyWith(color: appColor.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: appScreenUtil.size(30)),
                    CustomButton(
                      width: appScreenUtil.size(150),
                      title: 'VERIFY',
                      onTap: () {
                        otpVerificationCtrl.loginWithToken();
                      },
                    ),
                  ]),
                )),
          );
        }));
  }
}
