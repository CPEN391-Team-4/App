import 'package:flutter/material.dart';
import 'greet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    final notification = FirebaseNotification();
    notification.init();
    
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
            home: Greet(),
    );
  }
}
