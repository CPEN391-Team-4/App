import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'addUser.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:protobuf/protobuf.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'eachTrustedUser.dart';

class Users extends StatefulWidget {
  //it need to pass in two more arguments in, when the user is alrady there
  // the in = 1, also when click a old user, it will pass in the username
  @override
  _UsersState createState() => new _UsersState();
}

class _UsersState extends State<Users> {
  var channel;
  var stub;
  var trustedUser = [];

  @override
  Widget build(BuildContext context) {
    _updateTrustPeopleList();
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

  void connectStart() {
    channel = ClientChannel('192.168.0.101',
        port: 9000,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    stub = RouteClient(channel,
        options: CallOptions(timeout: Duration(seconds: 20)));
  }

  Future<void> connectEnd() async {
    await channel.shutdown();
  }

  Future<void> _updateTrustPeopleList() async {
    //print("updatelist");
    connectStart();

    try {
      var response = await stub.getAllUserNames(Empty());
      List allUserNames = response.usernames;
      //List newUserList = allUserNames;
      setState(() {
        trustedUser = allUserNames;
      });
    } catch (e) {
      print(e);
      print("Can not get all the names.");
    }
    connectEnd();
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
