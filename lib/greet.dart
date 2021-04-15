import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


// This is the page that the user first sees when they open the app
// From here the user will decide to login or signup
class Greet extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _GreetState();
    }
}

class _GreetState extends State<Greet> {
    @override
    void initState() {
        // initialize firebase messaging
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
            WidgetsFlutterBinding.ensureInitialized();
        });
        checkLogin();
    }

    // check if the user is already logged in
    void checkLogin() async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('login') != null && prefs.getBool('login')) {
            Get.off(Home(false, 0));
        }
    }

    @override
    Widget build(BuildContext context) {
        var _width = MediaQuery.of(context).size.width;
        return Scaffold(
                body: Container(
                        decoration: BoxDecoration(
                                gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.lightBlue[50], Colors.blue[800]],
                                ),
                        ),
                        child: 
                        ListView(
                                children:<Widget>[
                                    SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.20,
                                    ),
                                    Center(
                                            child: Text("Welcome",
                                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                    ),

                                    ),
                                    SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.37,
                                    ),
                                    Container(
                                            width: 100.0,
                                            height: 40.0,
                                            child:
                                            Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: _width*0.2),
                                                    child: 
                                                    RaisedButton(
                                                            child: Text("Login",
                                                                    style: TextStyle(fontSize: 18, fontWeight:  FontWeight.bold),
                                                                    ),
                                                            color: Colors.grey[100],
                                                            textColor: Colors.black,
                                                            onPressed: (){
                                                                Navigator.pushReplacement(
                                                                        context, 
                                                                        MaterialPageRoute(builder: (context) => Login()),
                                                                );
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                           borderRadius: BorderRadius.circular(30.0),
                                                                   ),
                                                    ),
                                            ),
                                            

                                    ),
                                    SizedBox(
                                            height: 20,
                                    ),
                                    Container(
                                            width: 100.0,
                                            height: 40.0,
                                            child:
                                            Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: _width*0.2),
                                                    child: 
                                                    RaisedButton(
                                                            child: Text("Sign Up",
                                                                    style: TextStyle(fontSize: 18, fontWeight:  FontWeight.bold),
                                                                    ),
                                                            color: Colors.grey[300],
                                                            textColor: Colors.black,
                                                            onPressed: (){
                                                                Navigator.pushReplacement(
                                                                        context, 
                                                                        MaterialPageRoute(builder: (context) => SignUp()),
                                                                );
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                           borderRadius: BorderRadius.circular(30.0),
                                                                   ),
                                                    ),
                                            ),
                                            

                                    ),
                                ],
                        ),
                ),
        );

    }

}
