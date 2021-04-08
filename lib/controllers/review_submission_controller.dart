import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';

import 'common/loader_controller.dart';

class ReviewSubmissionController extends GetxController with SingleGetTickerProviderMixin {
  var formKey = GlobalKey<FormState>();

  // TextEditingController txtDateTime = TextEditingController();
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
  String txtDateTime;
  List dateList = [];

  String pickDate;
  dynamic existingReview;

  dynamic selectedDateArray = ['2021-03-03', '2021-03-06', '2021-03-10', '2021-03-12', '2021-03-15'];

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
    // txtDateTime.text = formattedDate;
    txtDateTime = formattedDate;

    getReviewDateList();

    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getReviewDateList() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        Apis.getApi(visitDateAPI(empId), []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data;
            dateList = data['data'] ?? [];
            if (dateList.length > 0) {
              final date = dateList[0];
              pickDate = "${date['year']}-${date['month']}-${date['day']}";
            }
            getReview();
            update();
          } else {}
        }, onError: (e) {
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }

  updateDate(val) {
    var date = DateFormat('yyyy-MM-dd').format(val).toString();
    // txtDateTime.text = date;
    txtDateTime = date;
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
    return 0;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your review has been successfully submitted'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(Get.context);
              },
            ),
          ],
        );
      },
    );
  }

  void saveReview(isNavigation) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime,
          // "ratings": ratingCount,
          'questions': questions,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };

        Apis.postApi(reviewsAPI, formData).then((res) async {
          Loader().hideLoading();

          if (res.StatusCode == 200 || res.StatusCode == 201) {
            if (isNavigation) {
              Get.back();
              _showMyDialog();
              //  Get.offAndToNamed(AppRouter.home);
            }
          } else {}
        }, onError: (e) {
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }

  tapToSelectDate(text) {
    pickDate = text;
    getReview();
  }

  getReview() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Loader().showLoading();
        Apis.getApi(reviewDateWise(empId, pickDate), []).then((res) async {
          Loader().hideLoading();
          if (res.StatusCode == 200) {
            final data = res.Data;
            existingReview = data['data'] ?? null;
            txtComment.text = existingReview['comment'] ?? '';
            txtWish.text = existingReview['wish'] ?? '';
            questions = existingReview['questions'];
          } else {
            questions = [];
          }
          update();
        }, onError: (e) {
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }
}
