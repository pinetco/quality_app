import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'common/loading_controller.dart';

class HomeClientController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  RxBool _isLoading = false.obs;
  String _loginOption;
  int _currentIndex = 0;
  String _isoCode;

  bool get isLoading => _isLoading.value;

  String get isoCode => _isoCode;

  List workingList = [];
  List finishedList = [];
  List questionList = [];
  dynamic surveysList = [];
  dynamic userInfo;
  bool updateAlert = false;
  bool isRefreshing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    // wait untill widget load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // getUserInfo();
    getData();
    getSurveyList();
    // checkVersion();
    getAllQuestion();
    // getAppInformation(); // Add Your Code here.
    // });
    super.onInit();
  }

  /*getUserInfo() async {
    helper.showLoading();
    apis.call(apiMethods.userAPI, null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        userInfo = data;
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }*/

  // checkVersion() async {
  //   final checkVersion = CheckVersion(context: Get.context);
  //   final appStatus = await checkVersion.getVersionStatus();
  //   print("appStatus :");
  //   print(appStatus);
  //   if (appStatus.canUpdate) {
  //     checkVersion.showUpdateDialog("com.quality_app", 'com.quality_app');
  //   }
  //   print("canUpdate ${appStatus.canUpdate}");
  //   print("localVersion ${appStatus.localVersion}");
  //   print("appStoreLink ${appStatus.appStoreUrl}");
  //   print("storeVersion ${appStatus.storeVersion}");
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    txtMobile?.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Update Now"),
      onPressed: () {},
    );

    Widget cancelButton = FlatButton(
      child: Text("Later"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update Available"),
      content: Text("You can now update this app from store."),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getData() async {
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.clientHomeAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        print(data);
        final working = data['working'] ?? [];
        final finished = data['finished'] ?? [];
        workingList = working;
        finishedList = finished;
        updateAlert = true;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getData();
    return null;
  }

  // showAlertDialog(Get.context);
  /*getAppInformation() async {
    helper.showLoading();
    apis.call(apiMethods.appInformationAPI, null, apiType.get).then((res) async {
      helper.hideLoading();

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        print('data: $data');
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }*/

  getAllQuestion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        helper.showLoading();
        apis.call(apiMethods.questionsAPI, null, apiType.get).then((res) async {
          helper.hideLoading();
          if (res.data != null && res.validation == false) {
            final data = res.data['data'];
            update();
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
      Get.toNamed(routeName.bottomNavigationScreen);
    });
  }

  void logout() async {
    helper.removeSpecificKeyStorage(session.authToken);
    Get.offAndToNamed(routeName.login);
  }

  getSurveyList() async {
    helper.showLoading();
    print(apiMethods.surveysAPI);
    apis.call(apiMethods.surveysAPI, null, apiType.get).then((res) async {
      helper.hideLoading();

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        print('data: $data');
        surveysList = data;
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  // // Navigation to editProfile
  // navigateEditProfile(item) {
  //   print("@@@@@@@@@@@@@@@ $item");
  //   Get.toNamed(routeName.editProfile, arguments: item);
  // }
}
