import 'package:flutter/material.dart';
import 'login.dart';
import 'changePassword.dart';
//import 'package:flutter_ble_lib/flutter_ble_lib.dart';
//import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:flutter/cupertino.dart';
import 'connect.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'findDevices.dart';
import 'newBluetooth.dart';
import 'package:get/get.dart';

// This is the profile page where the user
// must connect to the De1 device
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  var devices = [];
  var username = "admin";
  @override
  void initState() {
    getDe1ID(username);
  }

  // Gets the ID of the De1 that we have already connected
  // to which is stored in the backend
  Future<void> getDe1ID(String userName) async {
    final ret = await connectStart(10);
    var stub = ret[0];
    var channel = ret[1];
    //print(image_address);

    final name = MainUser()..username = userName;
    try {
      var response = await stub.getDe1ID(name);
      setState(() {
        devices = [response.de1ID];
      });
    } catch (e) {
      print(e);
      await channel.shutdown();
      return;
    }
    await channel.shutdown();
  }

  // Widget that wraps our connected devices in a container
  Widget _listDevices(width) {
    final children = <Widget>[];
    for (var i = 0; i < devices.length; i++) {
      children.add(
        Row(
          children: <Widget>[
            Text(
              devices[i],
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      );

      children.add(SizedBox(height: 10));
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.15),
      child: ListView(shrinkWrap: true, children: children),
    );
  }

  // This is called when connect to a new device is called.
  // This takes us to the find devices page
  // which will handle bluetooth discovery and connections
  Future<void> connectToBluetooth() async {
    Get.to(FindDevices());
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.2),
              child: Center(
                child: Text("Devices Connected:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            _listDevices(_width),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.2),
              child: RaisedButton(
                  child: Text("Add A Security Device"),
                  onPressed: () {
                    Get.to(FindDevices());
                  }),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.2),
              child: RaisedButton(
                  child: Text("Change Password"), onPressed: () {
                      Get.to(ChangePassword());
                  }),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.3),
              child: RaisedButton(
                  child: Text("Logout"),
                  onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('login', false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
