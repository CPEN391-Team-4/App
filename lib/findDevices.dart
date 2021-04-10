import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindDevices extends StatefulWidget {
    @override
    _FindDevicesState createState() => new _FindDevicesState();
}

class _FindDevicesState extends State<FindDevices> {
    final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
    var flutterBlue;
    var _connectedDevice;
    var _services;

    @override
    void initState() {
        super.initState();
        flutterBlue = FlutterBlue.instance;
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
        print(device.id);
        if (device.name != "" && !devicesList.contains(device)) {
            print(device.name);
            setState(() {
                devicesList.add(device);
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
                                                onPressed: () {

                                                    setState(() async {
                                                        flutterBlue.stopScan();
                                                        try {
                                                            await device.connect();
                                                        } catch (e) {
                                                            if (e.code != 'already_connected') {
                                                                throw e;
                                                            }
                                                        } finally {
                                                            List<BluetoothService> services = await device.discoverServices();
                                                            services.forEach((service) async {
                                                                var characteristics = service.characteristics;
                                                                for(BluetoothCharacteristic c in characteristics) {
                                                                    List<int> value = await c.read();
                                                                    print(value);
                                                                }
                                                            });

                                                            await device.disconnect();
                                                        }
                                                    });
                                                },
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
