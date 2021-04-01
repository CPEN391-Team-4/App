import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_widget.dart';
import 'intermediate.dart';
import 'main.dart';
import 'globals.dart';

class FirebaseNotification {

    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        // If you're going to use other Firebase services in the background, such as Firestore,
        // make sure you call `initializeApp` before using other Firebase services.
        await Firebase.initializeApp();
        print("Firebase notification click*********");

    }


    FirebaseNotification();

    Future<FlutterLocalNotificationsPlugin> init() async{
        await Firebase.initializeApp();

        FlutterLocalNotificationsPlugin local_not = new FlutterLocalNotificationsPlugin();
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
        messaging.getToken().then((token) {
            print(token);
        });


        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
            print("Message received******************");
            await local_not.show(1, "Title", "Body", spec, payload: "payload");
        });

        // FirebaseMessaging.onMessageOpenedApp.listen((message) {
            // print("Please work*********");
        // });
        
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        return local_not;
    }
}
