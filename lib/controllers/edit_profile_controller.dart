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

  File profileImage;
  double uploadPercentage = 0;
  dynamic imageUrl;

  // TextEditingController
  TextEditingController txtEditUserName = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditPhoneNumber = TextEditingController();

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
    File _file;
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 80, maxHeight: 1350, maxWidth: 1080);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
      // int fLength = profileImage.length;
      uploadImage(_file);
      // profileImage.add({'file': _file});
      update();
    } else {
      print('No image selected.');
    }
  }

  galleryImageUpload() async {
    print('Press Gallery icon');
    getImage(ImageSource.gallery);
  }

  uploadImage(imagePath) async {
    print('imagePath, ${imagePath.path}');
    // helper.showLoading();

    if (!helper.isNullOrBlank(imagePath.path)) {
      // String fileName = imagePath.path.split('/').last;
      // String fileType = fileName.split('.').last;
      // String newName = "file.$fileType";

      int width = 0, height = 0;
      File image = imagePath; // Or any other way to get a File instance.
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      width = decodedImage.width;
      height = decodedImage.height;

      var data = {
        "file": await dio.MultipartFile.fromFile(imagePath.path),
      };
      print("Form Data : " + data.toString()); //do not delete
      var formData = dio.FormData.fromMap(data);

      onSendProgress(int send, int total) {
        uploadPercentage = send / total;
        // profileImage['percentage'] = uploadPercentage >= 1 ? 0.99 : uploadPercentage;
        update();
      }

      await apis.call(apiMethods.updateProfileAPI, formData, apiType.put, onSendProgress).then((res) async {
        helper.hideLoading();
        print("#######Data Is Printed $res");
        if (res?.isSuccess == true) {
          var data = res?.data['data'] ?? null;
          print("URL : ${data['image']}");
          // profileImage['id'] = data['id'];
          profileImage = data['profile_photo_url'];
          // profileImage['percentage'] = 1;
        } else if (res?.validation == true) {
          print("Error Section");
          helper.checkApiValidationError(res?.data);
        }
        update();
      });
    } else {
      helper.snackBar("Nothing to post");
    }
  }

  // GetProfile data function
  getProfileData() {
    var arguments = Get.arguments;

    txtEditUserName.text = arguments['name'];
    txtEditEmail.text = arguments['email'];
    txtEditPhoneNumber.text = arguments['phone'];
    imageUrl = arguments['profile_photo_url'];
    update();
  }

  // Update profile functions
  void updateProfileData() async {
    try {
      helper.showLoading();
      var formData = {
        "name": txtEditUserName.text,
        "email": txtEditEmail.text,
        "phone": txtEditPhoneNumber.text,
        "profile_photo_url": imageUrl,
      };

      // Printing Data
      print("Form Data : " + formData.toString()); //do not delete

      await apis.call(apiMethods.updateProfileAPI, formData, apiType.put).then((res) async {
        helper.hideLoading();
        if (res?.isSuccess == true) {
          userInfoUpdate();
          Get.back();
          helper.snackBar("Data updated successfully");
        } else if (res.validation == true) {
          helper.checkApiValidationError(res.data);
        }
        update();
      });
    } on Exception catch (e) {
      helper.apiExceptionMethod('EditProfileController - updateData', e);
    }
  }

  userInfoUpdate() {
    var bottomCtrl = Get.find<BottomNavigationController>();
    bottomCtrl.userInfo['name'] = txtEditUserName.text;
    bottomCtrl.userInfo['email'] = txtEditEmail.text;
    bottomCtrl.userInfo['phone'] = txtEditPhoneNumber.text;
  }

  navigationBack() {
    Get.back();
    //Get.offAll(AppRouter.home);
    // Navigator.pop(Get.context);
  }
}
