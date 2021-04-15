import 'package:get/get.dart';
import 'home_widget.dart';
import 'package:flutter/material.dart';
import 'login.dart';


// Deprecated intermediate page to help with notificaion
// navigation. Currently not used in the codebase
// but left in if future changes require needing an
// intermediate page
class Intermediate extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _IntermediateState();
    }
}

class _IntermediateState extends State<Intermediate> {
    @override
    void initState() {
        print("Intermediate");
    }

    @override
    Widget build(context) {
        return new Container();
    }

}
