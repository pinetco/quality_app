import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class EditProfileController extends GetxController {
  dynamic userInfo;
  var bottomCtrl = Get.find<BottomNavigationController>();
  final ImagePicker picker = ImagePicker();

  double uploadPercentage = 0;

  // TextEditingController
  TextEditingController txtEditUserName = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditPhoneNumber = TextEditingController();
  dynamic imageUrl;
  File selectedFile;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    getProfileData();
    super.onReady();
  }

  cameraImageUpload() {
    print('Select images');
    getImage(ImageSource.camera);
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 80, maxHeight: 1350, maxWidth: 1080);
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);

      update();
    } else {
      print('No image selected.');
    }
  }

  galleryImageUpload() async {
    print('Press Gallery icon');
    getImage(ImageSource.gallery);
  }

  updateProfileData() async {
    helper.showLoading();
    String fileName = '';

    if (selectedFile != null && !helper.isNullOrBlank(selectedFile.path)) {
      fileName = selectedFile.path.split('/').last;
    }

    dynamic data = {
      "name": txtEditUserName.text,
      "email": txtEditEmail.text,
      "phone": txtEditPhoneNumber.text,
      "_method": 'PUT',
      if (selectedFile != null) 'profile_picture': await dio.MultipartFile.fromFile(selectedFile.path, filename: fileName),
    };

    print("Form Data : " + data.toString()); //do not delete
    var formData = dio.FormData.fromMap(data);

    await apis.call(apiMethods.updateProfileAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res?.isSuccess == true) {
        var data = res?.data['data'] ?? null;

        var bottomCtrl = Get.find<BottomNavigationController>();
        bottomCtrl.userInfo = data;
        update();
        Get.back();
      } else if (res?.validation == true) {
        print("Error Section");
        helper.checkApiValidationError(res?.data);
      }
      update();
    });
  }

  // GetProfile
  getProfileData() {
    var arguments = Get.arguments;
    txtEditUserName.text = arguments['name'];
    txtEditEmail.text = arguments['email'];
    txtEditPhoneNumber.text = arguments['phone'];
    imageUrl = arguments['profile_photo_url'];
    update();
  }

  navigationBack() {
    Get.back();
  }
}
