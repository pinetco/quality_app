import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/notification_badge_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/utility/index.dart';

import 'index.dart';

//when app in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseNotificationService {
  init(context) {
    print('init');
    initNotification(context);
  }

  Future<void> initNotification(context) async {
    print('OWII');
    //when app in background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    }

    //when app is [closed | killed | terminated]
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        print("Notification -> closed | killed | terminated");
        _notificationNavigateToItemDetail(message.data);
      }
    });

    //for IOS
    Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                print("IOS Ok Notification Click");
              },
            ),
          ],
        ),
      );
    }

    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (val) async {
      print("On Local Click");
      print(val);
      if (val != null && val.length > 0) {
        print(jsonDecode(val));
        dynamic data = jsonDecode(val);
        _notificationNavigateToItemDetail(data);
      }
    });

    // var notificationBadgeCtrl = Get.find<NotificationBadgeController>();
    // notificationBadgeCtrl.getBadgeCount();

    //when app in foreground
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   var notificationBadgeCtrl = Get.find<NotificationBadgeController>();
    //   notificationBadgeCtrl.getBadgeCount();
    //
    //   //check for custom channel
    //   String channelId = message.notification.android.channelId;
    //   print('channelId : $channelId');
    //   print('message data : ${message.data}');
    //   //end check
    //
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && !kIsWeb) {
    //     // var notificationBadgeCtrl = Get.find<NotificationBadgeController>();
    //     // notificationBadgeCtrl.getBadgeCount();
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: channelId != null
    //             ? AndroidNotificationDetails(
    //                 channelId,
    //                 'custom notification title',
    //                 'custom notification description',
    //                 icon: android?.smallIcon,
    //                 //sound: sound,
    //               )
    //             : AndroidNotificationDetails(
    //                 channel.id,
    //                 channel.name,
    //                 channel.description,
    //                 icon: android?.smallIcon,
    //               ),
    //       ),
    //       payload: message.data != null ? jsonEncode(message.data) : null,
    //     );
    //   }
    // });
    //when app in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      var notificationBadgeCtrl = Get.find<NotificationBadgeController>();
      notificationBadgeCtrl.getBadgeCount();

      //if (notification != null && android != null && !kIsWeb) {
      if (notification != null && !kIsWeb) {
        String channelId;
        AndroidNotification android = message.notification?.android;
        if (android != null) {
          channelId = message.notification.android.channelId;
          print('channelId : $channelId');
        }

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelId ?? channel.id,
              channel.name,
              channel.description,
              icon: android?.smallIcon,
            ),
            iOS: IOSNotificationDetails(),
          ),
          payload: message.data != null ? jsonEncode(message.data) : null,
        );
      }
    });

    //when app in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification -> background");
      _notificationNavigateToItemDetail(message.data);
    });

    requestPermissions();
  }

  void _notificationNavigateToItemDetail(dynamic data) async {
    print("Call Notification");
    //check for custom channel
    //String channelId = message.notification.android.channelId;
    //print('channelId : $channelId');
    //print('message data : ${message.data}');
    //end check

    //dynamic data = message.data;

    if (!helper.isNullOrBlank(data)) {
      print("1st : ${data['data']}");
      var newData;
      if (data is String) {
        print("Yes String");
        newData = jsonDecode(data);
      } else {
        newData = data;
      }
      Get.toNamed(routeName.notification, arguments: newData);
    }
  }

  getToken() async {
    print('roken******************');
    String token = await FirebaseMessaging.instance.getToken();
    await helper.writeStorage(session.fcmToken, token);
    print("token : $token");
  }

  requestPermissions() async {
    print('Permission');
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
    //  if (settings.authorizationStatus == 'AuthorizationStatus.authorized') {
    getToken();
    //}
    print(settings.authorizationStatus);
  }
}
