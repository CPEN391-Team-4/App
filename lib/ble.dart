import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class FindDevices extends StatefulWidget {
    @override
    _FindDevicesState createState() => new _FindDevicesState();
}

class _FindDevicesState extends State<FindDevices> {
    @override
    void initState() {
        init();
    }

    void init() async {

        BleManager bleManager = BleManager();
        await bleManager.createClient(); //ready to go!

        bleManager.enableRadio();
        bleManager.startPeripheralScan().listen((r) {


        });


        bleManager.destroyClient(); //remember to release native resources when you're done!

    }

    @override
    Widget build(context) {
        return Container();

    }

}
