import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewSubmissionController extends GetxController with SingleGetTickerProviderMixin {
  var storeCtrl = Get.find<HomeClientController>();

  // TextEditingController txtDateTime = TextEditingController(); // do not remove
  TextEditingController txtComment = TextEditingController();
  TextEditingController txtWish = TextEditingController();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  dynamic empId;
  String? name;
  String? email;
  String? phone;
  String? userImage;
  String? date;
  dynamic visitId;
  dynamic questions = [];
  DateTime selectedDate = DateTime.now();

  int ratingCount = 5;
  RxString _ratingText = 'Very Good'.obs;

  String get isRatingText => _ratingText.value;
  Map? questionObj;
  String? txtDateTime;
  List dateList = [];

  String? pickDate;
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
    visitId = data['visitId'];
    date = data['date'];

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // txtDateTime.text = formattedDate; // do not remove
    txtDateTime = formattedDate;

    // getReviewDateList();

    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  openURL(val, type) {
    if (type == 'phone') {
      launch("tel://$val");
    }
    if (type == 'email') {
      final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: val, queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});
      launch(_emailLaunchUri.toString());
    }
  }

  updateDate(val) {
    var date = DateFormat('yyyy-MM-dd').format(val).toString();
    // txtDateTime.text = date; // do not remove
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
    // saveReview(false);
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
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          contentPadding: EdgeInsets.all(15),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    storeCtrl.getData();
                    Navigator.pop(Get.context!);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      MdiIcons.close,
                      size: appScreenUtil.size(30),
                      color: Colors.black54,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageAssets.checkMark,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: appScreenUtil.size(20)),
                    Text(helper.trans('thank_you'), style: appCss.bodyStyle3.copyWith(color: appColor.black22Color)),
                    Container(
                      width: appScreenUtil.screenActualWidth() - appScreenUtil.size(50),
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                      child: Text(
                        helper.trans('review_successfully_submitted'),
                        style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void saveReview(isNavigation) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        helper.showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime,
          'visit_id': visitId,
          // "ratings": ratingCount, // do not remove may be futur added
          'questions': questions,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };
        print(formData);
        print('formData');
        apis.call(apiMethods.reviewsAPI, formData, apiType.post).then((res) async {
          helper.hideLoading();

          if (res.data != null && res.validation == false) {
            if (isNavigation) {
              Get.back();
              _showMyDialog();
            }
          } else {}
        }, onError: (e) {
          helper.hideLoading();
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
        helper.showLoading();
        apis.call(apiMethods.reviewDateWise(visitId, pickDate), null, apiType.get).then((res) async {
          helper.hideLoading();
          if (res.data != null && res.validation == false) {
            final data = res.data['data'];
            existingReview = data ?? null;
            txtComment.text = existingReview['comment'] ?? '';
            txtWish.text = existingReview['wish'] ?? '';
            questions = existingReview['questions'];
          } else {
            questions = [];
          }
          update();
        }, onError: (e) {
          helper.hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }
}
