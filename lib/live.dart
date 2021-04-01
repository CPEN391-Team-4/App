import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:local_auth/local_auth.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'connect.dart';

class Live extends StatefulWidget {
    @override
    _LiveState createState() => new _LiveState();
}

class _LiveState extends State<Live> {
    File _imgFile = new File('');
    bool _inCall = false;
    bool _lockInCall = false;
    bool _unlockInCall = false;
    var stub;
    var channel;

    Future getImage() async {
        setInCall(true);
        await Future.delayed(Duration(seconds: 2), () {
            setInCall(false);
        });
        setState(() {
            _imgFile = File("/data/user/0/com.example.my_app/cache/image_picker224874259728420569.jpg");
        });
    }
    Future setInCall(bool val) async {
        setState(() {
            _inCall = val;
        });
    }
    Widget showInCall() {
        if (_inCall == true) {
            return Center(
                    child: CircularProgressIndicator(),
            );
        }
        else {
            return Container();
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
                                                Text(string1),
                                                Text(string2),
                                            ],
                                    ),
                            ),
                            actions: <Widget>[
                                TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                ),
                            ],
                    );
                },
                );
    }

    Future<void> connectEnd() async {
        await channel.shutdown();
    }

    void _unlockDoor(context) async {
        setState(() {
            _unlockInCall = true;
        });
        final ret = await connectStart();
        stub = ret[0];
        channel = ret[1];
        // await Future.delayed(Duration(seconds: 2), () {
            // setState(() {
                // _unlockInCall = false;
            // });
            // return _alert(context, "Door has been unlocked", "");
        // });
        final permissionRequest = Permission()..permit=true;
        try {
            var response = await stub.givePermission(permissionRequest);
        } catch (e) {
            print(e);
        }
        connectEnd();
    }

    void _lockDoor(context) async {
        setState(() {
            _lockInCall = true;
        });
        await Future.delayed(Duration(seconds: 2), () {
            setState(() {
                _lockInCall = false;
            });
            return _alert(context, "Door has been locked", "");
        });
    }
    void _door(context, unlock) async{
        var local_auth = LocalAuthentication();
        bool didAuthenticate = 
                await local_auth.authenticate(
                        localizedReason: 'Please authenticate to unlock door',
                );
        if (didAuthenticate == false) {
                return _alert(context, "Authentication Failed", "Please try again");
        }
        if (unlock == true) {
            _unlockDoor(context);
        }
        else {
            _lockDoor(context);
        }
    }
    Widget _lockButton(context) {
        if (_lockInCall == false) {
            return RaisedButton(
                    onPressed: () {
                        _door(context, false);
                    }, 
                    child: Text("Lock Door"),
            );
        }
        else {

            return RaisedButton(
                    onPressed: () {
                    },
                    child: Padding(
                                   padding: EdgeInsets.all(2.7),
                                   child:
                                   Center(child:CircularProgressIndicator(),),),
            );
        }
    }
    Widget _unLockButton(context) {
        if (_unlockInCall == false) {
            return RaisedButton(
                    onPressed: () {
                        _door(context, true);
                    }, 
                    child: Text("Unlock Door"),
            );
        }
        else {

            return RaisedButton(
                    onPressed: () {
                    },
                    child: Padding(
                                   padding: EdgeInsets.all(2.7),
                                   child:
                                   Center(child:CircularProgressIndicator(),),),
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
                title: Text("Live View"),
                centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
                children: <Widget>[
                        // top: 100,
                        // right: 50.0,
                        // showInCall(),
                Padding(
                        padding: EdgeInsets.symmetric(horizontal: _width*0.25),
                        child:
                        Container(
                        width: 10.0,
                        child: RaisedButton(
                                onPressed: getImage,
                                child: Text("Request Live Image"),
                        ),
                ),),


                SizedBox(height:10),

                setImage(_imgFile),
                SizedBox(height: 30),

                Padding(
                        padding: EdgeInsets.symmetric(horizontal: _width*0.1),
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                    _unLockButton(context),
                                    SizedBox(width: 20),
                                    _lockButton(context),

                                ],
                        ),
                )

                ],
          ),
        ),
    );
    }


    Widget setImage(File file) {
        if (_inCall == true) {
            return Center(
                    child: CircularProgressIndicator(),
            );
        }
        else {
            if (file.path == '') {
                return new Container(
                        width: 250.0,
                        height: 250.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                                image: DecorationImage(
                                        image: AssetImage('assets/profile.png')
                                )
                        )
                );
            }
            else {
                return new Container(
                        width: 250.0,
                        height: 250.0,
                        alignment: Alignment.center,
                        child: Image.file(file)
                );

            }

        }
    }
}

