import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class WishController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController txtwishComment = TextEditingController();

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
}
