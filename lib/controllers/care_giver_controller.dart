import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/networking/api_methods.dart';
import 'package:quality_app/packages/config_package.dart';

import 'common/loader_controller.dart';

class CareGiverController extends GetxController with SingleGetTickerProviderMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  // TextEditingController
  TextEditingController searchCareGiver = TextEditingController();

  List careGiverList = [];
  bool isRefreshing = false;

  // Stop search typing
  Timer searchOnStoppedTyping;

  @override
  void onInit() {
    // TODO: implement onInit
    // wait untill widget load
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    getCareGivers();
    // });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /* Start a search part functionality in controllers */
  onChangeText(query) async {
    const duration = Duration(milliseconds: 400); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      print('Cancel');
      searchOnStoppedTyping.cancel();
      update(); // clear timer
    }
    if (query.isEmpty) return null;
    searchOnStoppedTyping = new Timer(duration, () {
      print('Timer');
      String name;
      print('####### Search data for care giver  ######## $name');
      if (!isNumericUsingRegularExpression(query)) {
        name = query;
      }
      searchResultFromCareGiverAPI(name);
    });
  }

  // Create isNumericUsingRegularExpression functions
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }

  // search function for CareGivers api
  searchResultFromCareGiverAPI(name) async {
    if (name == null) {
      name = '';
    }
    print('Searching data $name');
    // Api code
    try {
      Loader().showLoading();
      return await apis.getApi(careGiversSearchAPI, []).then((res) async {
        print('resData, ${res.data}');
        Loader().hideLoading();
        if (res.isSuccess == true) {
          var data = res.data['data'];
          print('data, $data');
          update();
        }
      });
    } on Exception catch (e) {
      print(e);
      Loader().hideLoading();
      helper.alertMessage('something went wrong. Try again after some time');
    }
  }
  /* End a search part functionality in controllers */

  getCareGivers() async {
    if (!isRefreshing) Loader().showLoading();
    apis.getApi(careGiverListAPI, []).then((res) async {
      if (!isRefreshing) Loader().hideLoading();
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
    getCareGivers();
    return null;
  }
}
