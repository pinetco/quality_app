import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/global/packages/config_package.dart';

class PatientsController extends GetxController with SingleGetTickerProviderMixin {
  List patientsList = [];
  bool isRefreshing = false;
  var refreshPatientsKey = GlobalKey<RefreshIndicatorState>();
  // TextEditingController
  TextEditingController searchPatients = TextEditingController();
  Timer? searchOnStoppedTyping;

  bool checkInDisabled = false;

  @override
  void onInit() {
    // TODO: implement onInit
    getPatientsList('');
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
      searchOnStoppedTyping!.cancel();
      update(); // clear timer
    }
    searchOnStoppedTyping = new Timer(duration, () {
      String name = '';
      if (!isNumericUsingRegularExpression(query)) {
        name = query;
      }
      getPatientsList(name);
    });
  }

  // Create isNumericUsingRegularExpression functions
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }

  getPatientsList(name) async {
    if (!isRefreshing) helper.showLoading();
    apis.call(apiMethods.patientsAPI(name), null, apiType.get).then((res) async {
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

  checkButtonDisable(client_visit) {
    print('pending, $client_visit');
    final contain = client_visit.indexWhere((element) {
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
    print('checkInDisabled, $checkInDisabled');
    update();
  }

  Future<Null> refreshList() async {
    isRefreshing = true;
    getPatientsList('');
    return null;
  }

  navigateOtherProfile(item) {
    Get.toNamed(routeName.careGiverProfile, arguments: item);
  }
}
