import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile.dart';


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

    void startBluetooth() {
        deviceSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
            if (r.device.name == "FaceLock" && devicesList.every((element) => element.device.address != r.device.address)) {
                setState(() {
                   devicesList.add(r);
                });
            }
        });
    }

    void refresh() {
        setState(() {
            devicesList.clear();
        });
        startBluetooth();
    }

    @override
    void dispose() {
        deviceSubscription.cancel();
        super.dispose();
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
                                                            Text(device.device.name == null ? '(unknown device)' : device.device.name),
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
                                                    BluetoothConnection connection = await BluetoothConnection.toAddress(device.device.address);
                                                    print("Connected to "+device.device.name);
                                                    var send = utf8.encode("devid\r\n"); //Convert string to bytes
                                                    var deviceID = BytesBuilder();
                                                    connection.input.listen((data) async {
                                                        deviceID.add(data);
                                                        if (deviceID.toBytes()[deviceID.length-1] == 10) {
                                                            print(deviceID.toBytes().toString());
                                                            _sendIDtoBackend(deviceID.toBytes().toString());
                                                            await connection.close();
                                                            await connection.finish();
                                                            connection.dispose();
                                                            deviceSubscription.cancel();
                                                            _alert(context, "Successfully connected device", "");
                                                            refresh();
                                                            Get.off(Profile());
                                                        }
                                                    }).onDone(() {
                                                    });

                                                    connection.output.add(send); 
                                                }
            ),
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

    void _sendIDtoBackend(id) {
        // Make GRPC call

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
