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
  String userImage;
  dynamic questions = [];
  DateTime selectedDate = DateTime.now();

  int ratingCount = 5;
  RxString _ratingText = 'Very Good'.obs;

  String get isRatingText => _ratingText.value;
  Map questionObj;

  @override
  void onInit() {
    var data = Get.arguments;
    empId = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    userImage = data['userImage'];

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
    selectedDate = val;
    update();
  }

  void selectedReview(count, text, id) {
    ratingCount = count;
    _ratingText.value = text ?? '';
    int index = questions.indexWhere((data) => data['id'] == id);
    if (index > -1) {
      questions[index]['ratings'] = count;
    } else {
      questionObj = {"id": id, "ratings": count};
      questions.add(questionObj);
    }
    update();
    saveReview(false);
  }

  int getReviewEmoji(id, count) {
    dynamic filterList = questions.where((data) => data['id'] == id).toList();
    if (filterList.length > 0) {
      final ratings = filterList[0]['ratings'];

      // if (ratings == count) {
      return ratings;
      // }
    }
    return 3;
  }

  void saveReview(isNavigation) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime.text,
          // "ratings": ratingCount,
          'questions': questions,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };

        Apis.postApi(reviewsAPI, formData).then((res) async {
          Loader().hideLoading();

          if (res.StatusCode == 200 || res.StatusCode == 201) {
            if (isNavigation) Get.offAndToNamed(AppRouter.home);
          } else {}
        }, onError: (e) {
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }
}
