import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'eachTrustedUser.dart';
import 'connect.dart';

// Uses the non low energy bluetooth library to
// interface with the De1 
class FindDevices extends StatefulWidget {
  @override
  _FindDevicesState createState() => new _FindDevicesState();
}

class _FindDevicesState extends State<FindDevices> {
  List<BluetoothDiscoveryResult> devicesList = List<BluetoothDiscoveryResult>();
  StreamSubscription<BluetoothDiscoveryResult> deviceSubscription;

  @override
  void initState() {
    startBluetooth();
  }

  // Start bluetooth discovery and adds discovered devices to
  // the device list array
  void startBluetooth() {
    deviceSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      if (r.device.name == "FaceLock" &&
          devicesList
              .every((element) => element.device.address != r.device.address)) {
        setState(() {
          devicesList.add(r);
        });
      }
    });
  }

  // Refresh the bluetooth status
  void refresh() {
    setState(() {
      devicesList.clear();
    });
    deviceSubscription.cancel();
    startBluetooth();
  }

  // When we dispose the app, we need to make sure that
  // the bluetooth is not still scanning
  @override
  void dispose() {
    deviceSubscription.cancel();
    super.dispose();
  }

  // Widget that shows an alert to the user
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

  // Widget that shows the devices list wrapped in a container
  // so that the user is able to connect with the device
  ListView _buildListViewOfDevices() {
    List<Container> containers = new List<Container>();
    for (BluetoothDiscoveryResult device in devicesList) {
      containers.add(
        Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.device.name == null
                        ? '(unknown device)'
                        : device.device.name),
                    Text(device.device.address.toString()),
                  ],
                ),
              ),
              FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                      // this function will connect to the De1 using 
                      // the protocol that we specified, get the 
                      // device ID and then send it to the server
                      // to link the user and device ID
                    BluetoothConnection connection =
                        await BluetoothConnection.toAddress(
                            device.device.address);
                    print("Connected to " + device.device.name);
                    var send =
                        utf8.encode("devid\r\n"); //Convert string to bytes
                    var deviceID = BytesBuilder();
                    connection.input.listen((data) async {
                      deviceID.add(data);
                      if (deviceID.toBytes()[deviceID.length - 1] == 10) {
                        var idstring = utf8.decode(deviceID.toBytes());
                        // Strip off the \r\n
                        _sendIDtoBackend(
                            idstring.substring(0, idstring.length - 2));
                        await connection.close();
                        await connection.finish();
                        connection.dispose();
                        deviceSubscription.cancel();
                        _alert(context, "Successfully connected device", "");
                        refresh();
                        Get.off(Profile());
                      }
                    }).onDone(() {});

                    connection.output.add(send);
                  }),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  // Makes a GRPC call with the device id to send
  // it to the backend so that we can link the device id
  // to the user
  Future<void> _sendIDtoBackend(id) async {
    // Make GRPC call
    print("send de1 id to server");
    final ret = await connectStart(10);
    var stub = ret[0];
    var channel = ret[1];

    try {
      var username = "admin";
      var de1info = BluetoothInfo()..de1ID = id;
      de1info.username = username;
      final res = await stub.sendDe1ID(de1info);
    } catch (e) {
      print(e);
      await channel.shutdown();
      return;
    }
    await channel.shutdown();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connect to Security Device"),
      ),
      body: _buildListViewOfDevices(),
    );
  }
}
