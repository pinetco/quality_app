import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quality_app/networking/api_methods.dart';

class RateYourDayController extends GetxController with SingleGetTickerProviderMixin {
  var storeCtrl = Get.find<HomeClientController>();

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

  bool anonymousUser = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
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

  void selectedReview(count, text, id) {
    ratingCount = count;
    _ratingText.value = text ?? '';
    update();
  }

  anonymousFeedback() {
    anonymousUser = !anonymousUser;
    update();
  }
}
