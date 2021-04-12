import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'home_widget.dart';

class ChangePassword extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _ChangePasswordState();
    }
}

class _ChangePasswordState extends State<ChangePassword> {
    var _pass = '';
    var _pass1 = '';
    var _pass2 = '';
    bool _inCall = false;
    int _pwdStatus = 0;
    Widget _changeButton(width, context) {
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
                    padding: EdgeInsets.symmetric(horizontal: width*0.1),
                    child: 
                    RaisedButton(
                            onPressed: () {
                                _change(context);
                            },
                            child: Text("Change Password"),
                    ),
            );

        }
    }

  Future<void> _alert(context, string1, string2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Password Successfully Changed'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                  Get.off(Home(false, 3));
              },
            ),
          ],
        );
      },
    );
  }

    Future _change(context) async{
        final prefs = await SharedPreferences.getInstance();
        var password = prefs.getString('password');
        if (_pass1 != _pass2) {
            setState(() {
                _pwdStatus = 2;
            });
            return;
        }
        else if (_pass1.length < 4) {
            setState(() {
                _pwdStatus = 3;
            });
            return;
        }
        else if ((_pass != password)) {
            print(_pass);
            print(password);
            setState(() {
                _pwdStatus = 1;
            });
        }
        else {
            setState(() {
                _inCall = true;
                _pwdStatus = 0;
            });
            await Future.delayed(Duration(seconds: 1), () async {
                setState(() {
                    _inCall = false;
                });
                prefs.setString('password', _pass1);
                _alert(context, "", "");
            });

        }
    }
    Widget _auth() {
        if (_pwdStatus == 0) {
            return SizedBox(height: 17);
        }
        if (_pwdStatus == 1) {
            return Container(
                    height: 17,
                    child: Center(child:Text(
                            "Orignal Password is not correct",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
        }
        if (_pwdStatus == 3) {
            return Container(
                    height: 17,
                    child: Center(child:Text(
                            "Password must be at least 4 chars",
                            style: TextStyle(color: Colors.red),
                    ),),
            );
        }
        if (_pwdStatus == 2) {
            return Container(
                    height: 17,
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
                appBar: AppBar(
                        title: Text('Change Password'),
                        centerTitle: true,
                ),
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
                                            child: Text("Change Password",
                                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                                                                                        labelText: 'Orignal Password',
                                                                                        hintText: '',
                                                                                        labelStyle: TextStyle(color: Colors.black, 
                                                                                                fontSize:  16,
                                                                                                fontWeight:  FontWeight.bold),
                                                                                ),
                                                                                style: TextStyle(color: Colors.black),
                                                                                obscureText: true,
                                                                                enableSuggestions: false,
                                                                                autocorrect: false,
                                                                                onChanged: (val) {
                                                                                    setState(() {
                                                                                        _pass = val;
                                                                                    });
                                                                                },
                                                                        ),
                                                                        SizedBox(height: 15),
                                                                        TextField(
                                                                                decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        labelText: 'New Password',
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
                                                                        _changeButton(_width, context),

                                                                    ],) 

                                                    ),
                                            ),
                                    ),
                                    SizedBox(height:10),
                                ],
                        ),
                ),
        );
    }

}
