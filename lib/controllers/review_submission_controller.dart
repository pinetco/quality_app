import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';

import 'common/loader_controller.dart';

class ReviewSubmissionController extends GetxController with SingleGetTickerProviderMixin {
  var formKey = GlobalKey<FormState>();

  TextEditingController txtDateTime = TextEditingController();
  TextEditingController txtRating = TextEditingController();
  TextEditingController txtComment = TextEditingController();
  TextEditingController txtWish = TextEditingController();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  int empId;
  int ratingCount;
  RxString _ratingText = 'Very Good'.obs;

  String get isRatingText => _ratingText.value;

  @override
  void onInit() {
    var data = Get.arguments;
    print(data['id']);
    empId = data['id'];

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

  getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        List formData = [];
        // setState(() {
        //   isLoading = true;
        // });
        Apis.postApi("GetOffice", formData).then((data) async {
          if (data.IsSuccess == true && data.Data.length > 0) {
            // setState(() {
            //   list = data.Data;
            //   isLoading = false;
            // });
          } else {
            // setState(() {
            //   list.clear();
            //   isLoading = false;
            // });
          }
        }, onError: (e) {
          // setState(() {
          //   list.clear();
          //   isLoading = false;
          //});
        });
      }
    } on SocketException catch (_) {
      // setState(() {
      //   list.clear();
      //   isLoading = false;
      // });
      //showMsg("अपने इंटरनेट की जाँच करें या कुछ समय बाद फिर से कोशिश करें !");
    }
  }

  void selectedReview(count, text) {
    ratingCount = count;
    _ratingText.value = text ?? '';
    print(text);
  }

  void saveReview() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime.text,
          "ratings": txtRating.text,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };

        Apis.postApi(reviewsAPI, formData).then((res) async {
          // Loader().hideLoading();
          if (res.StatusCode == 200) {
            print(res);
            Get.offAndToNamed(AppRouter.home);
          } else {
            // setState(() {
            //   list.clear();
            //   isLoading = false;
            // });
          }
        }, onError: (e) {
          // Loader().hideLoading();
          print('review');
          if (e.response != null) {
            // print(e.response.data);
            print(e.response.headers);
            // print(e.response.request);
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            print(e.request.data);
            print(e.message);
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
