import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification {

    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        // If you're going to use other Firebase services in the background, such as Firestore,
        // make sure you call `initializeApp` before using other Firebase services.
        await Firebase.initializeApp();

        print("Handling a background message: ${message.messageId}");
    }


    FirebaseNotification();

    void init() async{
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
        final androidSettings = AndroidInitializationSettings('app_icon');
        final iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: (int id, 
                        String title, String body, String payload){});
        final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
        local_not.initialize(settings, onSelectNotification: (String payload) {
        });
        final spec = NotificationDetails(android: androidSpec, iOS: iosSpec);

        FirebaseMessaging messaging = FirebaseMessaging.instance;
        messaging.getToken().then((token) {
            print("**************\n");
            print(token);
        });

        FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
            await Firebase.initializeApp();
            await local_not.show(1, "Test Title", message.notification.body, spec, payload: "payload");
        });

        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
            print('Got a message whilst in the foreground!');
            await local_not.show(1, message.notification.title, message.notification.body, spec, payload: "payload");
        });

    }
}
