import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

import 'common/loader_controller.dart';

class StoreController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  RxBool _isLoading = false.obs;
  String _loginOption;
  int _currentIndex = 0;
  String _isoCode;

  bool get isLoading => _isLoading.value;
  String get isoCode => _isoCode;

  // RxList<dynamic> _itemList = [].obs;
  //
  // List<dynamic> get items => _itemList.value;

  List itemList = [];
  List questionList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    _loginOption = 'mobile';
    update();
    getData();

    getAllQuestion();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    txtMobile?.dispose();
    super.dispose();
  }

  getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        Apis.getApi(employeesAPI, []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data['data'];
            itemList = data;

            update();
          } else {}
        }, onError: (e) {
          print('e');
        });
      }
    } on SocketException catch (_) {
      print('Socket');
    }
  }

  getAllQuestion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        Apis.getApi(questionsAPI, []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            print(res);
            final data = res.Data['data'];
            questionList = data;

            update();
          } else {}
        }, onError: (e) {
          print('e');
        });
      }
    } on SocketException catch (_) {
      print('Socket');
    }
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

  void login() {
    _isLoading.value = true;
    Timer(Duration(seconds: 1), () {
      _isLoading.value = false;
      Get.toNamed(AppRouter.bottomNavigationScreen);
    });
  }
}
