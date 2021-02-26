import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';

import 'common/loader_controller.dart';

class ReviewSubmissionController extends GetxController with SingleGetTickerProviderMixin {
  var formKey = GlobalKey<FormState>();

  TextEditingController txtDateTime = TextEditingController();
  TextEditingController txtComment = TextEditingController();
  TextEditingController txtWish = TextEditingController();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  int empId;
  String name;
  String email;
  String phone;

  int ratingCount = 5;
  RxString _ratingText = 'Very Good'.obs;

  String get isRatingText => _ratingText.value;

  @override
  void onInit() {
    var data = Get.arguments;
    empId = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    txtDateTime.text = formattedDate;

    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateDate(val) {
    var date = DateFormat('yyyy-MM-dd').format(val).toString();
    txtDateTime.text = date;
    update();
  }

  void selectedReview(count, text) {
    ratingCount = count;
    _ratingText.value = text ?? '';
  }

  void saveReview() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime.text,
          "ratings": ratingCount,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };

        Apis.postApi(reviewsAPI, formData).then((res) async {
          Loader().hideLoading();
          print(res.toString());
          if (res.StatusCode == 200 || res.StatusCode == 201) {
            Get.offAndToNamed(AppRouter.home);
          } else {}
        }, onError: (e) {
          Loader().hideLoading();
          if (e.response != null) {
            // print(e.response.data);
            // print(e.response.headers);
            // print(e.response.request);
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            // print(e.request.data);
            // print(e.message);
          }
        });
      }
    } on SocketException catch (_) {
      // setState(() {
      //   list.clear();
      //   isLoading = false;
      // });
    }
  }
}
