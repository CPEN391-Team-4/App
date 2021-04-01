import 'package:flutter/material.dart';
import 'greet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification.dart';
import 'package:get/get.dart';
import 'home_widget.dart';
import 'dart:math';




void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    
    runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _MyAppState();
    }
}

class _MyAppState extends State<MyApp> {
    bool check = true;
    @override
    void initState() {
        setCheck();
    }

    Future<bool> setCheck() async {
        FirebaseMessaging.onMessageOpenedApp.listen((message) async {
            WidgetsFlutterBinding.ensureInitialized();
        });
        await Future.delayed(Duration(seconds: 6));
        Get.off(Home(false,0));
    }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      if (check == true) {
          return MaterialApp(
                  home:Greet(),
          );

      }
      else {
          return MaterialApp(
                  home:Home(false,0),
          );
      }
  }
}
