import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class ForgotPasswordController extends GetxController {
  var formForgotKey = GlobalKey<FormState>();

  TextEditingController txtMobile = TextEditingController();
  String? _isoCode;
  String? _dialCode = '+49';

  String? get isoCode => _isoCode;
  String? get dialCode => _dialCode;

  String? phoneFieldError;

  void updateIsoCode(String isoCode, String dialCode) {
    _isoCode = isoCode;
    _dialCode = dialCode;
    update();
  }

  void otpSent() async {
    final formData = {
      // 'phone': txtMobile.text != '' ? '$dialCode${txtMobile.text}' : '', // Do Not Remove
      'phone': dialCode! + txtMobile.text,
    };
    print('formData, $formData');
    helper.showLoading();

    apis.call(apiMethods.forgotPasswordAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        Get.toNamed(routeName.otpVerification, arguments: {'phone': dialCode! + txtMobile.text});
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        phoneFieldError = errors['phone'] != null ? errors['phone'][0] : '';
        update();
      }
    }, onError: (e) {
      helper.hideLoading();
    });
  }
}
