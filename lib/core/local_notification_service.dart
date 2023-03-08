import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'cache_helper.dart';
import 'constants.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /* final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String?> selectNotificationSubject =
  BehaviorSubject<String?>();

  const MethodChannel platform =
  MethodChannel('dexterx.dev/flutter_local_notifications_example');*/

  static _requestPermissions() {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void initialize(BuildContext context) {
    _requestPermissions();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
    void onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      if(CacheHelper.getData(key: 'enable_notification',defaultValue: true)){
        showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title ?? ''),
            content: Text(body ?? ''),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () async {
                  selectNotification(payload,context);
                  //  Navigator.of(context, rootNavigator: true).pop();
                  //  navigateTo(context, PrayerScreen());
                },
              )
            ],
          ),
        );
      }

    }

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }



  static Future<dynamic> selectNotification(
      String? route, BuildContext context) async {
    if (route != null) {
    }
  }

  static void display(RemoteMessage message) async {
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String page =
          message.data['page'] != null ? message.data['page']! : "none";
      String itemId =
          message.data['id'] != null ? message.data['id']!.toString() : "none";
      String categoryName = message.data['category_name'] != null
          ? message.data['category_name']!
          : "none";
      String haveSubCategory = message.data['have_subCategory'] != null
          ? message.data['have_subCategory']!
          : "none";
      String payload =
          page + "^" + itemId + "^" + categoryName + "^" + haveSubCategory;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "souqApproach",
            "souqApproach channel",
            channelDescription:"this is our channel",
            vibrationPattern: vibrationPattern,
            enableLights: true,
              playSound:true,
          //  color: const Color.fromARGB(255, 255, 0, 0),
       //     ledColor: const Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentSound:true,sound: 'slow_spring_board.aiff'));
if(CacheHelper.getData(key: 'enable_notification',defaultValue: true)) {
        await _notificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: payload,
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
