import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'connect.dart';

class History extends StatefulWidget {
    @override
    _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
                appBar: AppBar(
                        title: Text('History'),
                ),
                body: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ListView(
                                children: <Widget>[
                                    Row(
                                            children: <Widget>[
                                                Text("Hello"),
                                                Text("This"),
                                            ],
                                    ),
                                ],
                        ),
                ),
        );
    }
}
