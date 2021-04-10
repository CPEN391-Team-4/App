import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_widget.dart';
import 'intermediate.dart';
import 'main.dart';
import 'globals.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'connect.dart';

class FirebaseNotification {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Firebase notification click*********");
  }

  FirebaseNotification();

  Future<FlutterLocalNotificationsPlugin> init() async {
    await Firebase.initializeApp();

    FlutterLocalNotificationsPlugin local_not =
        new FlutterLocalNotificationsPlugin();
    final androidSpec = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'test ticker',
    );

    final iosSpec = IOSNotificationDetails();
    // final androidSettings = AndroidInitializationSettings('app_icon');
    // final iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: (int id,
    // String title, String body, String payload){});
    // final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    final spec = NotificationDetails(android: androidSpec, iOS: iosSpec);

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((token) async {
      print(token);
      String deviceid = await _getId();
      print(deviceid);
      updateDeviceInfo(token, deviceid);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Message received******************");
      await local_not.show(
          1, message.notification.title, message.notification.body, spec,
          payload: "payload");
    });

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return local_not;
  }

  Future<void> updateDeviceInfo(String tokenstr, String deviceid) async {
    print("333333");
    final ret = await connectStart(10);
    var stub = ret[0];
    var channel = ret[1];
    var deviceinfo = DeviceVerify()
      ..deviceid = deviceid
      ..token = tokenstr;
    print(deviceinfo);
    try {
      var res = await stub.updateDeviceToken(deviceinfo);
    } catch (e) {
      await channel.shutdown();
      return;
    }
    await channel.shutdown();
  }

  Future<String> _getId() async {
    var deviceId = "";
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceId = build.androidId;
    }
    if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      deviceId = build.identifierForVendor;
    }
    return deviceId;
  }
}
