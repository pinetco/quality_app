import 'package:quality_app/controllers/forgot_password_controller.dart';
import 'package:quality_app/controllers/otp_verification_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/global/widgets/phone_number_with_country.dart';

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
      body: LoadingComponent(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
              child: Column(children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'OTP Verification',
                        style: appCss.h1,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: appScreenUtil.size(15)),
              ]),
            )),
      ),
    );
  }
}
