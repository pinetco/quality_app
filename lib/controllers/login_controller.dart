import 'dart:convert';
import 'dart:io';

import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

final storage = GetStorage();

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
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
    tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    // Loader().showLoading();
    // await Future.delayed(Duration(seconds: 5));
    // Loader().hideLoading();
    final loginCRD = storage.read('loginCredential');
    if (loginCRD != null) {
      final jsonDecode = json.decode(loginCRD);
      _isoCode = jsonDecode['iso_code'];
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
    tabController.dispose();
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
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        final formData = {
          'phone': txtMobile.text != '' ? '+1497449196605' : '',
          'password': txtPassword.text,
        };

        if (isRememberLogin) {
          final loginDetails = {
            'iso_code': isoCode,
            "mobile": txtMobile.text,
            "password": txtPassword.text,
          };
          storage.write("loginCredential", json.encode(loginDetails));
        }

        Apis.postApi(loginAPI, formData).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data['data'];

            storage.write(Session.authToken, data['token']);
            Get.offAndToNamed(AppRouter.home);
          } else if (res.StatusCode == 422) {
            final data = res.Data;

            final errors = data['errors'];
            phoneFieldError = errors['phone'] != null ? errors['phone'][0] : '';
            passwordFieldError = errors['password'] != null ? errors['password'][0] : '';

            update();
          }
        }, onError: (e) {
          Loader().hideLoading();
          if (e.response != null) {
            // print(e.response.data);
            // print(e.response.headers);
            // print(e.response.request);
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            // print(e.request.data);
            // print(e.message);
          }
        });
      }
    } on SocketException catch (_) {
      // setState(() {
      //   list.clear();
      //   isLoading = false;
      // });
    }
  }
}
