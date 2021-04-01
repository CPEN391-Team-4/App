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
        title: Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildListView(context),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
                itemCount: trustedUser.length,
                itemBuilder: (_, index) {
                  final username = trustedUser[index];
                  return ListTile(
                    title: new Text(trustedUser[index]),
                    subtitle: Text("subtitle"),
                    leading: Icon(Icons.people),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print("work");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EachUserScreen(
                                    userName: username,
                                  )));
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider();
                })),
        TextButton(
          child: Text(
            "Add Users",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUserScreen()));
          },
        ),
      ],
    );
  }
}
