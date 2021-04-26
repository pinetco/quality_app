import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forceupdate/forceupdate.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/networking/api_methods.dart';

import 'common/loader_controller.dart';

class HomeEmpController extends GetxController with SingleGetTickerProviderMixin {
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

  List pendingList = [];
  List finishedList = [];

  List questionList = [];
  bool updateAlert = false;
  dynamic userInfo;
  bool isRefreshing = false;
  bool checkInDisabled = false;

  @override
  void onInit() {
    // TODO: implement onInit
    // wait untill widget load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    getUserInfo();
    getData();
    // checkVersion();
    getAllQuestion();
    //getAppInformation(); // Add Your Code here.
    // });

    super.onInit();
  }

  getUserInfo() async {
    Loader().showLoading();
    apis.getApi(userAPI, []).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        userInfo = data;
        print(data);
        await helper.writeStorage(Session.userInfo, data);
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  checkVersion() async {
    final checkVersion = CheckVersion(context: Get.context);
    final appStatus = await checkVersion.getVersionStatus();
    print("appStatus :");
    print(appStatus);
    if (appStatus.canUpdate) {
      checkVersion.showUpdateDialog("com.quality_app", 'com.quality_app');
    }
    print("canUpdate ${appStatus.canUpdate}");
    print("localVersion ${appStatus.localVersion}");
    print("appStoreLink ${appStatus.appStoreUrl}");
    print("storeVersion ${appStatus.storeVersion}");
  }

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
    if (!isRefreshing) Loader().showLoading();
    apis.getApi(employeeHomeAPI, []).then((res) async {
      if (!isRefreshing) Loader().hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        final pending = data['pending'] ?? [];
        final finished = data['finished'] ?? [];
        pendingList = pending;
        finishedList = finished;
        updateAlert = true;
        checkButtonDisable(pending);
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  checkButtonDisable(pending) {
    final contain = pending.indexWhere((element) {
      final clientVisit = element['client_visit'];
      if (clientVisit != null && clientVisit['is_running'] == true) {
        return clientVisit['is_running'] == true;
      }
      return false;
    });
    if (contain > -1) {
      checkInDisabled = true;
    } else {
      checkInDisabled = false;
    }
    update();
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getData();
    return null;
  }

  // showAlertDialog(Get.context);
  getAppInformation() async {
    print('info');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        apis.getApi(appInformationAPI, []).then((res) async {
          Loader().hideLoading();

          if (res.data != null && res.validation == false) {
            final data = res.data['data'];
            print('data: $data');
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
        apis.getApi(questionsAPI, []).then((res) async {
          Loader().hideLoading();
          if (res.data != null && res.validation == false) {
            final data = res.data['data'];
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

  void logout() async {
    helper.removeSpecificKeyStorage(Session.authToken);
    Get.offAndToNamed(AppRouter.login);
  }

  checkIn(id) {
    final formData = {'client_id': id};

    Loader().showLoading();
    apis.postApi(checkInAPI, formData).then((res) async {
      Loader().hideLoading();

      if (res.data != null && res.validation == false) {
        print(res.data);
        //  final data = res.data['data'];
        getData();
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  checkOut(id) {
    Loader().showLoading();
    apis.putApi(checkOutAPI(id), []).then((res) async {
      Loader().hideLoading();

      if (res.data != null && res.validation == false) {
        print(res.data);
        //  final data = res.data['data'];
        getData();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }
}
