import 'package:flutter/material.dart';
import 'package:quality_app/global/theme/index.dart';
import 'package:quality_app/global/utility/app_screen_util.dart';

// used _ (underscore) for only used in this file
AppScreenUtil _appScreenUtil = AppScreenUtil();

//font weight
const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight thick = FontWeight.w900;

//font family
String textFontFamily = "Poppins";

//Functions
TextStyle textExtraBold(double size) {
  return TextStyle(
    fontSize: _appScreenUtil.fontSize(size),
    fontWeight: extraBold,
    //color: textPrimaryColor,
  );
}

TextStyle textSemiBold(double size) {
  return TextStyle(
    fontSize: _appScreenUtil.fontSize(size),
    fontWeight: semiBold,
    //color: textPrimaryColor,
  );
}

TextStyle textRegular(double size) {
  return TextStyle(
    fontSize: _appScreenUtil.fontSize(size),
    color: appColor.grayColor,
  );
}

TextStyle textLetterSpacing(double size) {
  return TextStyle(
    letterSpacing: size,
  );
}

TextStyle textHeader() {
  return TextStyle(
    fontSize: _appScreenUtil.fontSize(30),
    color: appColor.primaryColor,
  );
}

TextStyle validationStyle(double size) {
  return TextStyle(fontSize: _appScreenUtil.fontSize(size), color: Colors.red, fontWeight: FontWeight.w500);
}

class AppCss {
  //Text Style
  TextStyle header = textHeader();

  TextStyle h1 = textSemiBold(24);

  TextStyle h2 = textSemiBold(22);

  TextStyle h3 = textSemiBold(20);

  TextStyle h4 = textSemiBold(18);

  TextStyle h5 = textSemiBold(16);

  TextStyle h6 = textSemiBold(14);

  TextStyle h7 = textSemiBold(12);

  TextStyle h8 = textSemiBold(10);

  TextStyle bodyStyle1 = textRegular(24);

  TextStyle bodyStyle2 = textRegular(22);

  TextStyle bodyStyle3 = textRegular(20);

  TextStyle bodyStyle4 = textRegular(18);

  TextStyle bodyStyle5 = textRegular(16);

  TextStyle bodyStyle6 = textRegular(14);

  TextStyle bodyStyle7 = textRegular(12);

  TextStyle bodyStyle8 = textRegular(10);

  TextStyle bodyStyle9 = textRegular(8);

//Letter Spacing
  TextStyle ls1 = textLetterSpacing(1);

  TextStyle ls2 = textLetterSpacing(2);

  TextStyle ls3 = textLetterSpacing(3);

  TextStyle ls4 = textLetterSpacing(4);

  TextStyle ls5 = textLetterSpacing(5);

//Validation

  TextStyle validationTextStyle = validationStyle(14);
}
