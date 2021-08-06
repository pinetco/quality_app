import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class PatientsController extends GetxController with SingleGetTickerProviderMixin {
  List patientsList = [];
  bool isRefreshing = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // TextEditingController
  TextEditingController searchPatients = TextEditingController();
  Timer searchOnStoppedTyping;

  @override
  void onInit() {
    // TODO: implement onInit
    getPatientsList();
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
    // Api code
    //getPatientsList();
  }
/* End a search part functionality in controllers */

  getPatientsList() async {
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.patientsAPI, null, apiType.get).then((res) async {
      if (!isRefreshing) helper.hideLoading();
      isRefreshing = false;

      if (res.data != null && res.validation == false) {
        final data = res.data['data'];

        patientsList = data;

        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getPatientsList();
    return null;
  }

  navigateOtherProfile(item) {
    Get.toNamed(routeName.careGiverProfile, arguments: item);
  }
}
