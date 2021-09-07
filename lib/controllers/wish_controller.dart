import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class WishController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController txtwishComment = TextEditingController();
  String wishFieldError;

  @override
  void onInit() async {
    // TODO: implement onInit

    update();
    // getPhoneNumber();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  sendRequest() {
    wishFieldError = '';
    update();

    final formData = {'description': txtwishComment.text};
    helper.showLoading();
    apis.call(apiMethods.createRequestAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final message = res.data['message'];
        txtwishComment.clear();
        //helper.successMessage(message.toUpperCase());

        update();
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        wishFieldError = errors['description'] != null ? errors['description'][0] : '';

        update();
      }
    }, onError: (e) {
      print('e');
    });
  }
}
