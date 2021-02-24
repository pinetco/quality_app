import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
}
