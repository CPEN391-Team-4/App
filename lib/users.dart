import 'package:flutter/material.dart';
import 'addUser.dart';

class Users extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
                appBar: AppBar(
                        title: Text('Users'),
                ),
                body: Center(
                        child: ListView(children: <Widget>[
                            RaisedButton(
                                    child: Text(
                                            "Add Users",
                                            style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                        builder: (context) => AddUserScreen()));
                                    },
                            )
                            ])),
                            );
    }
}
