import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_app/app_init.dart';
import 'package:quality_app/controllers/common/loading_controller.dart';
import 'package:quality_app/controllers/splash_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await GetStorage.init();
  Get.put(LoadingController());
  Get.put(SplashController());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        debugShowCheckedModeBanner: false,
        // translations: Language(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'), // tran
        title: "My App",
        home: AppInit(),
        getPages: appRoute.getPages,
        theme: appTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        themeMode: themeService.getThemeMode(),
      ),
    );
  }
}
