import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'live.dart';
import 'history.dart';
import 'users.dart';
import 'profile.dart';
import 'main.dart';
import 'globals.dart';
import 'notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
    bool notif;
    int selected;
    Home(this.notif, this.selected);
    @override 
    State<StatefulWidget> createState() {
        return _HomeState(notif, selected);
    }
}

class _HomeState extends State<Home> {
    int selected;
    bool notif;
    _HomeState(this.notif, this.selected);

    void init() async {
        final notification = FirebaseNotification();
        FlutterLocalNotificationsPlugin local_not = await notification.init();
        final androidSettings = AndroidInitializationSettings('app_icon');
        final iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: (int id, 
                        String title, String body, String payload){});
        final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
        local_not.initialize(settings, onSelectNotification: (String payload) {
            onNotification();
        });


        FirebaseMessaging.onMessageOpenedApp.listen((message) {
            WidgetsFlutterBinding.ensureInitialized();
            onNotification();
        });
    }

    void onNotification() {
        setState(() {
            selected = 0;
        });
        // Communicate with server here after 
        // receiving notifications
    }


    @override
    void initState() {
        init();
        if (notif == true) {
            getNotificationImage();
        }
    }

    void getNotificationImage() {

    }

    final List<Widget> _render = [
        Live(),
        Users(),
        History(),
        Profile(),
    ];

    void onTabTapped(int index) {
        setState(() {
            selected = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold( 
                body: _render[selected],
                bottomNavigationBar: BottomNavigationBar(
                        currentIndex: selected,
                        onTap: onTabTapped,
                        type: BottomNavigationBarType.fixed,
                        items: [
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.enhance_photo_translate_rounded),
                                    title: new Text('Live'),
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.supervised_user_circle),
                                    title: new Text('Users'),
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.history ),
                                    title: new Text('History')
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.person),
                                    title: new Text('Profile')
                            )
                        ],
                ),
                );
    }
}
