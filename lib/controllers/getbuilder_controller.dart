//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/models/local_data.dart';

class GetBuilderController extends GetxController {
  int count = 0;

  int get counterValue => count;

  void increment() {
    count++;
    update();
  }

  /*var list = List().obs;
  var data = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  void getData() async {
    await Future.delayed(Duration(seconds: 1));
    list.value = listData;
  }

  void addMore() {
    list.add({'id': '11', 'name': 'Nameeeeee'});
  }*/
}
