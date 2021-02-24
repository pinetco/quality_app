import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_app/app_init.dart';
import 'package:quality_app/controllers/splash_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/theme/theme_service.dart';
import 'package:quality_app/utility/language_list.dart';

void main() async {
  await GetStorage.init();
  Get.put(LoaderController());
  Get.put(SplashController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        debugShowCheckedModeBanner: false,
        translations: Language(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'), // tran
        title: "My App",
        home: AppInit(),
        getPages: AppRouter.getPages,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeService().getThemeMode(),
      ),
    );
  }
}
