import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindDevices extends StatefulWidget {
    @override
    _FindDevicesState createState() => new _FindDevicesState();
}

class _FindDevicesState extends State<FindDevices> {
    final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();

    @override
    void initState() {
        super.initState();
        FlutterBlue flutterBlue = FlutterBlue.instance;
        flutterBlue.connectedDevices
                .asStream()
                .listen((List<BluetoothDevice> devices) {
                    for (BluetoothDevice device in devices) {
                        _addDeviceTolist(device);
                    }
                });
        flutterBlue.scanResults.listen((List<ScanResult> results) {
            for (ScanResult result in results) {
                _addDeviceTolist(result.device);
            }
        });
        flutterBlue.startScan();
    }

    void _addDeviceTolist(final BluetoothDevice device) {
        if (device.name != "" && !devicesList.contains(device)) {
            setState(() {
                devicesList.add(device);
                print("Here");
            });
        }
    }

    ListView _buildListViewOfDevices() {
        List<Container> containers = new List<Container>();
        for (BluetoothDevice device in devicesList) {
            print("Adding");
            containers.add(
                    Container(
                            height: 70,
                            child: Row(
                                    children: <Widget>[
                                        Expanded(
                                                child: Column(
                                                        children: <Widget>[
                                                            Text(device.name == '' ? '(unknown device)' : device.name),
                                                            Text(device.id.toString()),
                                                        ],
                                                ),
                                        ),
                                        FlatButton(
                                                color: Colors.blue,
                                                child: Text(
                                                        'Connect',
                                                        style: TextStyle(color: Colors.white),
                                                ),
                                                onPressed: () {},
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
