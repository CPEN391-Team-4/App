import 'package:flutter/material.dart';
import 'AddTrustPeoplePage.dart';
import 'LoginPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name MainPage'),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
          child: ListView(children: <Widget>[
        RaisedButton(
          child: Text(
            "AddTrustedPeoplePage",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTrustPeopleScreen()));
          },
        ),
        RaisedButton(
          child: Text(
            "LoginPage",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ])),
    );
  }
}
