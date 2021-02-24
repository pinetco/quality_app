export 'package:quality_app/theme/style_color.dart';
export 'package:quality_app/theme/style_sheet.dart';
export 'package:quality_app/theme/image.dart';

import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    primaryColor: primaryColor,
    canvasColor: bgColor,
    appBarTheme: AppBarTheme(color: primaryColor, iconTheme: IconThemeData(color: primaryColor.withOpacity(0.8))),
    iconTheme: IconThemeData(color: primaryColor.withOpacity(0.4)),
    cardColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.red,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: textPrimaryColor),
      bodyText2: TextStyle(color: textPrimaryColor),
      headline4: TextStyle(color: textPrimaryColor),
      headline1: TextStyle(color: textPrimaryColor),
    ),
    //unselectedWidgetColor: Colors.blue[400],
    /*buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent,
      textTheme: ButtonTextTheme.primary,
    ),*/
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[700],
    canvasColor: Colors.grey[800],
    toggleableActiveColor: Colors.grey[300],
    appBarTheme: AppBarTheme(color: Colors.grey[900], iconTheme: IconThemeData(color: Colors.grey[100])),
    iconTheme: IconThemeData(color: Colors.grey[300]),
    cardColor: Colors.black,
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
    ),
    /*unselectedWidgetColor: Colors.grey[300],
    dividerColor: Colors.grey[500],
    buttonTheme: ButtonThemeData(buttonColor: Colors.grey[900], textTheme: ButtonTextTheme.primary),*/
  );
}
