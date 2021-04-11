import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:local_auth/local_auth.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:my_app/protobuf/video.pb.dart';
import 'protobuf/video.pb.dart';
import 'protobuf/video.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'connect.dart';

class Live extends StatefulWidget {
  @override
  _LiveState createState() => new _LiveState();
}

class _LiveState extends State<Live> {
  File _imgFile = new File('../assets/profile.png');
  bool _inCall = false;
  bool _lockInCall = false;
  bool _unlockInCall = false;
  var stub;
  var channel;
  bool livestate = false;

  var imgAsBytes = null;

  Future getImage() async {
    setInCall(true);
    await Future.delayed(Duration(seconds: 2), () {
      setInCall(false);
    });
    setState(() {
      _imgFile = File(
          "/data/user/0/com.example.my_app/cache/image_picker224874259728420569.jpg");
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
    } else {
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

  Future<void> permission(context, permit) async {
    print("enter give permission call");
    final ret = await connectStart(5);
    stub = ret[0];
    channel = ret[1];
    final permissionRequest = Permission()..permit = permit;
    try {
      var res = await stub.givePermission(permissionRequest);
      // if (permit == true) {
      //   _alert(context, "Door has been unlocked", "Please try again");
      // } else {
      //   _alert(context, "Door has been locked", "Please try again");
      // }
    } catch (e) {
      // _alert(context, "An error occured", "Please try again");
      connectEnd();
      return;
    }
    connectEnd();
    return;
  }

  void _unlockDoor(context) async {
    setState(() {
      _unlockInCall = true;
    });
    await permission(context, true);
    setState(() {
      _unlockInCall = false;
    });
  }

  void _lockDoor(context) async {
    setState(() {
      _lockInCall = true;
    });
    await permission(context, false);
    setState(() {
      _lockInCall = false;
    });
  }

  Future<Void> normalUnlock() async {
    print("enter normal unlock call");
    final ret = await connectStart(20);
    stub = ret[0];
    channel = ret[1];
    final request = LockDoorReq()..locked = false;
    try {
      var res = await stub.lockDoor(request);
      if (res.success == true) {
        _alert(context, "Door has been unlocked", "");
      } else {
        _alert(context, "Door has been locked", "Please try again");
      }
    } catch (e) {
      // _alert(context, "An error occured", "Please try again");
      print(e);
      connectEnd();
    }
    connectEnd();
  }

  Future<Void> normalLock() async {
    print("enter normal lock call");
    final ret = await connectStart(500);
    stub = ret[0];
    channel = ret[1];
    final request = LockDoorReq()..locked = true;
    try {
      var res = await stub.lockDoor(request);
      if (res.success == true) {
        _alert(context, "Door has been locked", "");
      } else {
        _alert(context, "Lock Door request did not send success",
            "Please try again");
      }
    } catch (e) {
      // _alert(context, "An error occured", "Please try again");
      print(e);
      connectEnd();
    }
    connectEnd();
  }

  void _door(context, unlock) async {
    // var local_auth = LocalAuthentication();
    // bool didAuthenticate = await local_auth.authenticate(
    //   localizedReason: 'Please authenticate',
    // );
    // if (didAuthenticate == false) {
    //   return _alert(context, "Authentication Failed", "Please try again");
    // }

    if (unlock == true) {
      _unlockDoor(context);
      normalUnlock();
    } else {
      _lockDoor(context);
      normalLock();
    }
    return;
  }

  Widget _lockButton(context) {
    if (_lockInCall == false) {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
        onPressed: () {
          _door(context, false);
        },
        child: Text("Lock Door"),
      );
    } else {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.all(2.7),
          child: Center(
            child: Text("Lock Door"),
          ),
        ),
      );
    }
  }

  Widget _unLockButton(context) {
    if (_unlockInCall == false) {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
        onPressed: () {
          _door(context, true);
        },
        child: Text("Unlock Door"),
      );
    } else {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.all(2.7),
          child: Center(
            child: Text("Unlock Door"),
          ),
        ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.25),
              child: Container(
                width: 10.0,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightGreen)),
                  onPressed: (() {
                    LiveStream();
                  }),
                  child: livestate
                      ? Text("Stop Live Stream")
                      : Text("Live Stream"),
                ),
              ),
            ),
            SizedBox(height: 10),
            setImage(_imgFile),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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

  void LiveStream() {
    setState(() => livestate = !livestate);
    if (livestate) {
      getLiveStream();
    } else {
      endLiveStream();
    }
  }

  Future<void> endLiveStream() async {
    print("end stream");
    final ret = await connectStartvideo();
    var stub;
    var channel;
    stub = ret[0];
    channel = ret[1];
    final endrequest = EndPullVideoStreamReq()..id = "default";
    try {
      final res = await stub.endPullVideoStream(endrequest);
    } catch (e) {
      print(e);
    }
    //connectEnd();
    await channel.shutdown();
  }

  Future<void> getLiveStream() async {
    print("start stream");
    setState(() {
      _imgFile = null;
    });
    var stub;
    var channel;
    final ret = await connectStartvideo();
    stub = ret[0];
    channel = ret[1];

    final streamRequest = PullVideoStreamReq()..id = "default";
    var framenumber = 0;
    try {
      await for (var streamResponse in stub.pullVideoStream(streamRequest)) {
        print(streamResponse.closed);
        if (streamResponse.closed == true) {
          print("closingggggggggggggggggggggggggggggggggggg");
          connectEnd();
          break;
        }
        var imageBytes = BytesBuilder();
        imageBytes.add(streamResponse.video.frame.chunk);
        print(streamResponse.video.frame.number);
        // print(imageBytes.toBytes());

        imageCache.clear();
        setState(() {
          imgAsBytes = imageBytes.toBytes();
        });

        framenumber += 1;
        await Future.delayed(Duration(milliseconds: 100));
      }
    } catch (e) {
      //connectEnd();
      await channel.shutdown();
      print(e);
    }

    print(framenumber);
    //connectEnd();
    await channel.shutdown();
  }

  Widget setImage(File file) {
    if (imgAsBytes != null) {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              image: DecorationImage(image: MemoryImage(imgAsBytes))));
    }

    if (file == null) {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/profile.png'))));
    } else {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          child: Image.file(file));
    }
  }
}
