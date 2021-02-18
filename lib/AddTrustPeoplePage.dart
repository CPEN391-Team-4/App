import 'package:flutter/material.dart';

class AddTrustPeopleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AddTrustPeople"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                // padding: const EdgeInsets.all(8.0),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Add People's Name",
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.accessibility)),
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  maxLength: 20,
                ),
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text(
                    "Add Photo",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(),
            ],
          ),
        ));
  }
}
