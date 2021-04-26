import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quality_app/networking/api_methods.dart';

class ReviewSubmissionController extends GetxController with SingleGetTickerProviderMixin {
  var storeCtrl = Get.find<HomeClientController>();

  // TextEditingController txtDateTime = TextEditingController();
  TextEditingController txtComment = TextEditingController();
  TextEditingController txtWish = TextEditingController();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  dynamic empId;
  String name;
  String email;
  String phone;
  String userImage;
  String date;
  dynamic visitId;
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
    visitId = data['visitId'];
    date = data['date'];

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // txtDateTime.text = formattedDate;
    txtDateTime = formattedDate;

    // getReviewDateList();

    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

/*  getReviewDateList() async {
    Loader().showLoading();
    apis.getApi(visitDateAPI(visitId), []).then((res) async {
      Loader().hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        dateList = data ?? [];
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
  }*/

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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    storeCtrl.getData();
                    Navigator.pop(Get.context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      MdiIcons.close,
                      size: screenWidth(30),
                      color: Colors.black54,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      checkMark,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: screenWidth(20)),
                    Text('Thank You', style: bodyStyle3.copyWith(color: black22Color)),
                    Container(
                      width: screenActualWidth() - screenWidth(50),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                      child: Text(
                        'Your review has been successfully submitted',
                        style: bodyStyle6.copyWith(color: grayColor),
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
        Loader().showLoading();

        final formData = {
          'employee_id': empId,
          'date': txtDateTime,
          'visit_id': visitId,
          // "ratings": ratingCount,
          'questions': questions,
          "comment": txtComment.text,
          "wish": txtWish.text,
        };
        print(formData);
        print('formData');
        apis.postApi(reviewsAPI, formData).then((res) async {
          Loader().hideLoading();

          if (res.data != null && res.validation == false) {
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
        apis.getApi(reviewDateWise(visitId, pickDate), []).then((res) async {
          Loader().hideLoading();
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
          Loader().hideLoading();
        });
      }
    } on SocketException catch (_) {}
  }
}
