import 'dart:async';
import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';


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
                                                    connection.output.add(send); 
                                                    connection.input.listen((data) {
                                                        print(data);
                                                    }).onDone(() {
                                                    });
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
