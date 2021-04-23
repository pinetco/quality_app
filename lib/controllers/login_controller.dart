import 'dart:convert';

import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  String _isoCode;
  String _dialCode;
  String phoneFieldError;
  String passwordFieldError;
  bool obscureText = true;

  bool _rememberLogin = false;

  String get isoCode => _isoCode;

  String get dialCode => _dialCode;

  bool get isRememberLogin => _rememberLogin;

  bool get isObscureText => obscureText;

  @override
  void onInit() async {
    // TODO: implement onInit
    // Loader().showLoading();
    // await Future.delayed(Duration(seconds: 5));
    // Loader().hideLoading();
    // _isoCode = 'PR';
    // _dialCode = '+51';
    // txtMobile.text = '54021928690';
    // txtPassword.text = 'password';

    final jsonDecode = helper.getStorage(Session.loginCredential);
    if (!helper.isNullOrBlank(jsonDecode)) {
      print(jsonDecode);
      _isoCode = jsonDecode['iso_code'];
      _dialCode = jsonDecode['dial_code'];
      txtMobile.text = jsonDecode['mobile'];
      txtPassword.text = jsonDecode['password'];
      _rememberLogin = true;
    }

    update();
    // getPhoneNumber();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    txtMobile?.dispose();
    super.dispose();
  }

  void updateIsoCode(String isoCode, String dialCode) {
    _isoCode = isoCode;
    _dialCode = dialCode;
    update();
  }

  void updateRememberLogin() {
    _rememberLogin = !_rememberLogin;
    update();
  }

  void togglePassword() {
    obscureText = !obscureText;
    update();
  }

  void getPhoneNumber() async {
    final SmsAutoFill _autoFill = SmsAutoFill();
    final completePhoneNumber = await _autoFill.hint;

    if (completePhoneNumber != null) {
      PhoneNumber numberRegionInfo = await PhoneNumber.getRegionInfoFromPhoneNumber(completePhoneNumber);
      txtMobile.text = int.parse(numberRegionInfo.parseNumber()).toString();
      _isoCode = numberRegionInfo.isoCode;
      update();
    }
  }

  void login() async {
    final formData = {
      'phone': txtMobile.text != '' ? '$dialCode${txtMobile.text}' : '',
      'password': txtPassword.text,
    };

    print(formData);

    if (isRememberLogin) {
      final loginDetails = {
        'iso_code': isoCode,
        "mobile": txtMobile.text,
        "password": txtPassword.text,
        "dial_code": dialCode,
      };
      helper.writeStorage(Session.loginCredential, loginDetails);
    }
    Loader().showLoading();

    apis.postApi(loginAPI, formData).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        helper.writeStorage(Session.authToken, data['token']);

        getUserInfo();
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        phoneFieldError = errors['phone'] != null ? errors['phone'][0] : '';
        passwordFieldError = errors['password'] != null ? errors['password'][0] : '';
        update();
      }
    }, onError: (e) {
      Loader().hideLoading();
    });
  }

  getUserInfo() async {
    Loader().showLoading();
    apis.getApi(userAPI, []).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];

        await helper.writeStorage(Session.userInfo, data);
        update();
        Get.offAndToNamed(AppRouter.bottomNavigationScreen);
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
