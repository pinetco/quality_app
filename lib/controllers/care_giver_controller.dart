import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/networking/index.dart';
import 'package:quality_app/global/packages/config_package.dart';

class CareGiverController extends GetxController with SingleGetTickerProviderMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  // TextEditingController
  TextEditingController searchCareGiver = TextEditingController();
  // Stop search typing
  Timer searchOnStoppedTyping;

  List careGiverList = [];
  bool isRefreshing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    // wait untill widget load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    getCareGivers('');
    // });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  onChangeText(query) async {
    const duration = Duration(milliseconds: 400); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      update(); // clear timer
    }
    searchOnStoppedTyping = new Timer(duration, () {
      String name = '';
      if (!isNumericUsingRegularExpression(query)) {
        print("@@@@@@ $query");
        name = query;
      }
      getCareGivers(name);
    });
  }

// Create isNumericUsingRegularExpression functions
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }

  getCareGivers(name) async {
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.careGiverListAPI(name), null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        careGiverList = data;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getCareGivers('');
    return null;
  }

  navigateOtherProfile(item) {
    Get.toNamed(routeName.careGiverProfile, arguments: item);
  }
}
