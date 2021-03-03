import 'package:flutter/material.dart';
import 'addUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class user {
    String name;
    bool restricted;

    user();
    user.fromJson(Map<String, dynamic> json ) :
        name = json['name'],
        restricted = json['restricted'];

        Map<String, dynamic> toJson() => {
            'name': name,
            'restricted': restricted,
        };
}

class Users extends StatelessWidget {
    save(String key, value) async{
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(key, json.encode(value));

    }
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
