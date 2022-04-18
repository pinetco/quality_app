import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/login_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class OTPVerificationController extends GetxController {
  var loginCtrl = Get.find<LoginController>();
  var formForgotKey = GlobalKey<FormState>();

  TextEditingController txtMobile = TextEditingController();
  String _isoCode;
  String _dialCode;

  String get isoCode => _isoCode;
  String get dialCode => _dialCode;

  String phoneFieldError = '';
  String tokenError = '';
  String code;
  String phone;

  @override
  void onInit() async {
    var data = Get.arguments;
    phone = data['phone'];
    update();
  }

  void updateIsoCode(String isoCode, String dialCode) {
    _isoCode = isoCode;
    _dialCode = dialCode;
    update();
  }

  void loginWithToken() async {
    phoneFieldError = '';
    tokenError = '';
    update();
    final formData = {
      // 'phone': phone != '' ? '$dialCode${phone}' : '',
      'phone': phone,
      "token": code,
      "device": "mobile",
    };
    print('formData, $formData');
    helper.showLoading();

    apis.call(apiMethods.loginWithTokenAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        helper.writeStorage(session.authToken, data['token']);
        Get.toNamed(routeName.changePassword);
        // loginCtrl.getUserInfo();
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        phoneFieldError = errors['phone'] != null ? errors['phone'][0] : '';
        tokenError = errors['token'] != null ? errors['token'][0] : '';
        update();
      }
    }, onError: (e) {
      helper.hideLoading();
    });
  }

  void otpSent() async {
    final formData = {
      'phone': phone,
    };
    print('formData, $formData');
    helper.showLoading();

    apis.call(apiMethods.forgotPasswordAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        helper.successMessage(helper.trans('otp_sent_successfully'));
      }
    }, onError: (e) {
      helper.hideLoading();
    });
  }
}
