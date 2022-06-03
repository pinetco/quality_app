import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/login/login_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class ChangePasswordController extends GetxController with SingleGetTickerProviderMixin {
  var formKey = GlobalKey<FormState>();
  var loginCtrl = Get.find<LoginController>();
  // var loginCtrl = Get.put(LoginController());

  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  String? passwordFieldError;
  String? cPasswordFieldError;
  bool obscureText = true;

  bool get isObscureText => obscureText;

  @override
  void dispose() {
    // TODO: implement dispose
    txtPassword.dispose();
    super.dispose();
  }

  void togglePassword() {
    obscureText = !obscureText;
    update();
  }

  void changePassword() async {
    FocusScope.of(Get.context!).requestFocus(new FocusNode()); //remove focus
    // WidgetsBinding.instance.addPostFrameCallback((_) => txtPassword.clear()); // clear content do not remove
    // txtPassword.clear();
    // txtConfirmPassword.clear();

    final formData = {
      'password': txtPassword.text,
      'password_confirmation': txtConfirmPassword.text,
    };
    passwordFieldError = '';
    cPasswordFieldError = '';
    update();
    helper.showLoading();

    apis.call(apiMethods.changePasswordAPI, formData, apiType.put).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        FocusScopeNode currentFocus = FocusScope.of(Get.context!);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        FocusScope.of(Get.context!).unfocus();
        txtPassword.clear();
        txtConfirmPassword.clear();
        loginCtrl.getUserInfo();
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        passwordFieldError = errors['password'] != null ? errors['password'][0] : '';
        cPasswordFieldError = errors['confirm_password'] != null ? errors['confirm_password'][0] : '';
        update();
      }
    }, onError: (e) {
      helper.hideLoading();
    });
  }
}
