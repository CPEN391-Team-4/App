import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class Profile extends StatefulWidget {
    @override
    _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
    var devices = ["Device 1", "Device 2"];
    Widget _listDevices(width) {
        final children = <Widget>[];
        for (var i = 0; i < devices.length; i++) {
            children.add(
                    Row(
                            children: <Widget>[
                                Padding(
                                        padding: EdgeInsets.symmetric(horizontal: width*0.05),
                                        child:
                                        RaisedButton(
                                                child: Text("Disconnect"),
                                                onPressed: () {

                                                },
                                                color: Colors.red[400],
                                        ),
                                ),
                                Text(
                                        devices[i],
                                        style: TextStyle(fontSize: 17,),
                                ),




                            ],),);

            children.add(SizedBox(height:10));
        }
        return Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.15),
                child:
                ListView(shrinkWrap: true, children: children),
                );

    }
    Future<void> connectToBluetooth() async {
        BleManager bleManager = BleManager();
        await bleManager.createClient();
        bleManager.startPeripheralScan(
                uuids: [
                    "F000AA00-0451-4000-B000-000000000000",
                ],
        ).listen((scanResult) {
            //Scan one peripheral and stop scanning
            print("Scanned Peripheral ${scanResult.peripheral.name}, RSSI ${scanResult.rssi}");
  bleManager.stopPeripheralScan();
});
        bleManager.destroyClient();
    }
    @override
    Widget build(BuildContext context) {
        var _width = MediaQuery.of(context).size.width;
        return Scaffold(
                appBar: AppBar(
                        title: Text('Profile'),
                ),
                body: Center(
                        child: ListView(
                                children:<Widget>[
                                    SizedBox(height: 20),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.2),
                                            child:
                                            Center(
                                                    child: Text("Devices Connected:",
                                                            style: TextStyle(fontSize: 18, fontWeight:  FontWeight.bold)),
                                            ),
                                    ),
                                    SizedBox(height: 20),
                                    _listDevices(_width),
                                    SizedBox(height: 20),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.2),
                                            child:
                                            RaisedButton(
                                                    child: Text("Add A Security Device"),
                                                    onPressed: () async {
                                                        await connectToBluetooth();
                                                    }
                                            ),
                                    ),
                                    SizedBox(height: 30),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.2),
                                            child:
                                            RaisedButton(
                                                    child: Text("Change Password"),
                                                    onPressed: () {

                                                    }
                                            ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                            padding: EdgeInsets.symmetric(horizontal: _width*0.4),
                                            child:
                                            RaisedButton(
                                                    child: Text("Logout"),
                                                    onPressed: () {
                                                        Navigator.pushReplacement(
                                                                context, 
                                                                MaterialPageRoute(builder: (context) => Login()),
                                                        );

                                                    }
                                            ),
                                    ),

                                ],
                        ),
                ),
        );
    }
}
