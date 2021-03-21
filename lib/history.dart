import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'connect.dart';

class History extends StatefulWidget {
    @override
    _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
    void writeToDisk() async {
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
                appBar: AppBar(
                        title: Text('History'),
                ),
                body: RaisedButton(
                        child: Text("File IO"),
                        onPressed: writeToDisk,
                ),
        );
    }
}
