import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class RateYourDayController extends GetxController with SingleGetTickerProviderMixin {
  var bottomCtrl = Get.find<BottomNavigationController>();

  TextEditingController txtSuggestion = TextEditingController();
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
  Map questionObj;
  DateTime selectedDate = DateTime.now();

  RxString _ratingText = 'Very Good'.obs;

  String get isRatingText => _ratingText.value;

  bool anonymousUser = false;

  dynamic questionListRateYourDay = [];

  @override
  void onInit() {
    getQuestionRateYourDay();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getQuestionRateYourDay() {
    helper.showLoading();
    apis.call(apiMethods.rateYourDayAPI, null, apiType.get).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final data = res.data['data'];
        questionListRateYourDay = data;
        print('data, $data');
        update();
      } else {}
    }, onError: (e) {
      print('e');
    });
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
                    Navigator.pop(Get.context);
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
                    Text('Thank You', style: appCss.bodyStyle3.copyWith(color: appColor.black22Color)),
                    Container(
                      width: appScreenUtil.screenActualWidth() - appScreenUtil.size(50),
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                      child: Text(
                        'Your review has been successfully submitted',
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
    // helper.showLoading();

    final formData = {
      'questions': questions,
      "suggestion": txtSuggestion.text,
      "is_anonymous": anonymousUser,
    };
    print(formData);

    apis.call(apiMethods.rateDaysAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();

      if (res.data != null && res.validation == false) {
        bottomCtrl.appSettings['is_today_rated'] = true;
        update();
        Get.back();
        _showMyDialog();
      } else {}
    }, onError: (e) {
      helper.hideLoading();
    });
  }

  void selectedReview(count, text, id) {
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

  anonymousFeedback() {
    anonymousUser = !anonymousUser;
    update();
  }
}
