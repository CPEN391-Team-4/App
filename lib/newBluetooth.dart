import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';


class FindDevices extends StatefulWidget {
    @override
    _FindDevicesState createState() => new _FindDevicesState();
}


class _FindDevicesState extends State<FindDevices> {
    List<BluetoothDiscoveryResult> devicesList = List<BluetoothDiscoveryResult>();

    @override
    void initState() {
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
            setState(() {
                devicesList.add(r);
            });
        });
    }


    ListView _buildListViewOfDevices() {
        List<Container> containers = new List<Container>();
        for (BluetoothDiscoveryResult device in devicesList) {
            print("Adding");
            containers.add(
                    Container(
                            height: 70,
                            child: Row(
                                    children: <Widget>[
                                        Expanded(
                                                child: Column(
                                                        children: <Widget>[
                                                            Text(device.device.name == '' ? '(unknown device)' : device.device.name),
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
                                                onPressed: () {}
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
