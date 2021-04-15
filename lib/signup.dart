import 'package:flutter/material.dart';
import 'login.dart';

// This is the signup page
class SignUp extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SignUpState();
    }
}

class _SignUpState extends State<SignUp> {
    var _username = '';
    var _pass1 = '';
    var _pass2 = '';
    bool _inCall = false;
    int _signUpStatus = 0;
    Widget _signUpButton(width, context) {
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
                                _signup(context);
                            },
                            child: Text("Sign Up"),
                    ),
            );

        }
    }
    Future<void> _alert(context) async {
        return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                    return AlertDialog(
                            content: SingleChildScrollView(
                                    child: ListBody(
                                            children: <Widget>[
                                                Text('Account successfully created'),
                                                Text('Please login to continue'),
                                            ],
                                    ),
                            ),
                            actions: <Widget>[
                                TextButton(
                                        child: Text('Login'),
                                        onPressed: () {
                                            Navigator.pushReplacement(
                                                    context, 
                                                    MaterialPageRoute(builder: (context) => Login()),
                                            );
                                        },
                                ),
                            ],
                    );
                },
                );
    }
    Future _signup(context) async{
        if (_pass1 != _pass2) {
            setState(() {
                _signUpStatus = 2;
            });
            return;
        }
        else if (_pass1.length < 4) {
            setState(() {
                _signUpStatus = 3;
            });
            return;
        }
        else if (_username.length < 4) {
            setState(() {
                _signUpStatus = 4;
            });
            return;
        }
        setState(() {
            _inCall = true;
            _signUpStatus = 0;
        });
        await Future.delayed(Duration(seconds: 1), () {
            setState(() {
                _inCall = false;
            });
            if ((_username == 'admin')) {
                setState(() {
                    _signUpStatus = 1;
                });
            }
            else {
                return _alert(context);
            }

        });
    }
    Widget _auth() {
        if (_signUpStatus == 0) {
            return SizedBox(height: 15);
        }
        if (_signUpStatus == 1) {
            return Container(
                    height: 15,
                    child: Center(child:Text(
                            "Username already exists",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
        }
        if (_signUpStatus == 4) {
            return Container(
                    height: 15,
                    child: Center(child:Text(
                            "Username must be at least 4 chars",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
        }
        if (_signUpStatus == 3) {
            return Container(
                    height: 15,
                    child: Center(child:Text(
                            "Password must be at least 4 chars",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
        }
        if (_signUpStatus == 2) {
            return Container(
                    height: 15,
                    child: Center(child:Text(
                            "Passwords do not match",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
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
                                            height: MediaQuery.of(context).size.height * 0.18,
                                    ),
                                    Center(
                                            child: Text("SignUp",
                                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                    ),
                                    ),
                                    Center(
                                            child: Text("Create an account",
                                                    style: TextStyle(fontSize: 15),
                                                    ),

                                    ),
                                    SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.05,
                                    ),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.1),
                                            child: 

                                            Container(
                                                    height: MediaQuery.of(context).size.height * 0.45,
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
                                                                                        _pass1 = val;
                                                                                    });
                                                                                },
                                                                        ),
                                                                        SizedBox(height: 15),
                                                                        TextField(
                                                                                decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        labelText: 'Re-type Password',
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
                                                                                        _pass2 = val;
                                                                                    });
                                                                                },
                                                                        ),
                                                                        _auth(),
                                                                        _signUpButton(_width, context),

                                                                    ],) 

                                                    ),
                                            ),
                                    ),
                                    SizedBox(height:10),
                                    GestureDetector(
                                            onTap: () {
                                                Navigator.pushReplacement(
                                                        context, 
                                                        MaterialPageRoute(builder: (context) => Login()),
                                                );

                                            },
                                            child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: <Widget> [
                                                               Text(
                                                                       "Already have an account? ",
                                                                       style: TextStyle(color:Colors.cyan[50], fontWeight: FontWeight.bold,
                                                                               fontSize: 15),
                                                               ),
                                                               Text(
                                                                       "Login", 
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
