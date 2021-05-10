import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quality_app/packages/config_package.dart';

class FirebaseNotification {
  String _token;
  Stream<String> _tokenStream;

  initNotification() async {
    // print('init');
    // await Firebase.initializeApp();
    //
    // // Set the background messaging handler early on, as a named top-level function
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    //
    // /// Create an Android Notification Channel.
    // ///
    // /// We use this channel in the `AndroidManifest.xml` file to override the
    // /// default FCM channel to enable heads up notifications.
    // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    //
    // /// Update the iOS foreground notification presentation options to allow
    // /// heads up notifications.
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    getToken();
    //listenNotification();
  }

  getToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      helper.writeStorage(Session.fcmToken, token);
      print(token);
    });

    // _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    // _tokenStream.listen(setToken);
  }
/*
  listenNotification() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        Get.toNamed(AppRouter.login);
//        Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Get.toNamed(AppRouter.login);
      // Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
    });
  }*/
}
