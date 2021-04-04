import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _LoginState();
    }
}

class _LoginState extends State<Login> {
    var _username = '';
    var _pass = '';
    bool _inCall = false;
    int _loginStatus = 0;


    Widget _loginButton(width, context) {
        if (_inCall == true) {
            return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.2),
                    child: 
                    RaisedButton(
                            onPressed: () {
                            },
                            child: Padding(
                                           padding: EdgeInsets.all(2.7),
                                           child:
                                           Center(child:CircularProgressIndicator(),),),
                    ),
            );
        }
        else {
            return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.2),
                    child: 
                    RaisedButton(
                            onPressed: () {
                                _login(context);
                            },
                            child: Text("Login"),
                    ),
            );

        }
    }
    Widget _auth() {
        if (_loginStatus == 0) {
            return SizedBox(height: 15);
        }
        if (_loginStatus == 1) {
            return Container(
                    height: 15,
                    child: Center(child:Text(
                            "Incorrect username or password.",
                            style: TextStyle(color: Colors.red),
                    ),),
            );


        }

    }

    Future _login(context) async{
        setState(() {
            _inCall = true;
            _loginStatus = 0;
        });
        await Future.delayed(Duration(seconds: 1), () {
            setState(() {
                _inCall = false;
            });
            if (!(_username == 'admin' && _pass == 'admin')) {
                setState(() {
                    _loginStatus = 1;
                });
            }
            else {
                Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => Home(false, 0)),
                );
            }

        });


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
                                            height: MediaQuery.of(context).size.height * 0.18,
                                    ),
                                    Center(
                                            child: Text("Login",
                                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                    ),
                                    ),
                                    Center(
                                            child: Text("Sign in to your account",
                                                    style: TextStyle(fontSize: 15),
                                                    ),

                                    ),
                                    SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.10,
                                    ),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.1),
                                            child: 

                                            Container(
                                                    height: MediaQuery.of(context).size.height * 0.40,
                                                    decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                            color: Colors.grey[100],
                                                    ),
                                                    child: 

                                                    Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: _width*0.1),
                                                            child: ListView(
                                                                    children: <Widget>[
                                                                        SizedBox(height: 30),
                                                                        TextField(
                                                                                decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        labelText: 'User Name',
                                                                                        hintText: '',
                                                                                        labelStyle: TextStyle(color: Colors.black, 
                                                                                                fontSize:  16,
                                                                                                fontWeight:  FontWeight.bold),
                                                                                ),
                                                                                style: TextStyle(color: Colors.black),
                                                                                autocorrect: false,
                                                                                onChanged: (val) {
                                                                                    setState(() {
                                                                                        _username = val;
                                                                                    });
                                                                                },
                                                                        ),
                                                                        SizedBox(height: 15),
                                                                        TextField(
                                                                                decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        labelText: 'Password',
                                                                                        hintText: '',
                                                                                        labelStyle: TextStyle(color: Colors.black, 
                                                                                                fontSize:  16,
                                                                                                fontWeight:  FontWeight.bold),
                                                                                ),
                                                                                style: TextStyle(color: Colors.black),
                                                                                obscureText: true,
                                                                                autocorrect: false,
                                                                                enableSuggestions: false,
                                                                                onChanged: (val) {
                                                                                    setState(() {
                                                                                        _pass = val;
                                                                                    });
                                                                                },
                                                                        ),
                                                                        _auth(),
                                                                        _loginButton(_width, context),



                                                                    ],) 

                                                    ),
                                            ),
                                    ),
                                    SizedBox(height:10),
                                    GestureDetector(
                                            onTap: () {
                                                Navigator.pushReplacement(
                                                        context, 
                                                        MaterialPageRoute(builder: (context) => SignUp()),
                                                );

                                            },
                                            child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: <Widget> [
                                                               Text(
                                                                       "Don't have an account? ",
                                                                       style: TextStyle(color:Colors.cyan[50], fontWeight: FontWeight.bold,
                                                                               fontSize: 15),
                                                               ),
                                                               Text(
                                                                       "Sign Up", 
                                                                       style: TextStyle(fontWeight: FontWeight.bold,
                                                                               fontSize: 15, 
                                                                               color: Colors.white,
                                                                               decoration: TextDecoration.underline),
                                                               ),

                                                           ],),
                                                   ),
                                ],
                        ),
                ),
        );

    }
}
