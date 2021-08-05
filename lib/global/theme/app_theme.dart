import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_css.dart';

AppColor _color = AppColor();

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    //for page effect
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    //Define the default font family
    fontFamily: textFontFamily,
    //Default colors
    scaffoldBackgroundColor: _color.bgColor,
    primaryColor: _color.primaryColor,
    buttonColor: _color.primaryColor,
    accentColor: _color.primaryColor,
    backgroundColor: _color.bgColor,
    dividerColor: _color.dividerColor,
    dialogBackgroundColor: _color.whiteColor,
    canvasColor: _color.bgColor,
    //appBarTheme: AppBarTheme(color: _color.primaryColor, iconTheme: IconThemeData(color: Colors.white)),
    appBarTheme: AppBarTheme(color: _color.primaryColor),
    //iconTheme: IconThemeData(color: _color.primaryColor),
    iconTheme: IconThemeData(color: _color.textPrimaryColor),
    cardColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.red,
    ),
    textTheme: TextTheme(
      //header
      headline1: TextStyle(color: _color.textPrimaryColor),
      headline2: TextStyle(color: _color.textPrimaryColor),
      headline3: TextStyle(color: _color.textPrimaryColor),
      headline4: TextStyle(color: _color.textPrimaryColor),
      headline5: TextStyle(color: _color.textPrimaryColor),
      headline6: TextStyle(color: _color.textPrimaryColor),
      //subtitle
      subtitle1: TextStyle(color: _color.textPrimaryColor),
      subtitle2: TextStyle(color: _color.textPrimaryColor),
      //body
      bodyText1: TextStyle(color: _color.textPrimaryColor),
      bodyText2: TextStyle(color: _color.textPrimaryColor),
      //button
      button: TextStyle(color: _color.buttonTextColor),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    //for page effect
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    //Define the default font family
    fontFamily: textFontFamily,
    //Default colors
    scaffoldBackgroundColor: Colors.grey[700],
    buttonColor: Colors.white,
    accentColor: _color.primaryColor,
    backgroundColor: _color.bgColor,
    dividerColor: Colors.white,
    dialogBackgroundColor: Colors.grey[800],
    canvasColor: Colors.grey[800],
    toggleableActiveColor: Colors.grey[300],
    appBarTheme: AppBarTheme(color: Colors.grey[900], iconTheme: IconThemeData(color: Colors.grey[100])),
    iconTheme: IconThemeData(color: Colors.grey[300]),
    cardColor: Colors.grey[800],
    textTheme: TextTheme(
      //header
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      //subtitle
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      //body
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      //button
      button: TextStyle(color: _color.buttonTextColor),
    ),
  );
}
