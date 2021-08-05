import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_app/app_init.dart';
import 'package:quality_app/controllers/common/loading_controller.dart';
import 'package:quality_app/controllers/splash_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message **** ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  await GetStorage.init();
  Get.put(LoadingController());
  Get.put(SplashController());

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
