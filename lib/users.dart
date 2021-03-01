import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'addUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:protobuf/protobuf.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class Users extends StatelessWidget {
  var channel;
  var stub;
  final trustedUser = [];

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

      // body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: ListView(children: [
      //

      //       _buildListView()
      //     ]))
    );
  }

  void connectStart() {
    channel = ClientChannel('192.168.0.100',
        port: 9000,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    stub = RouteClient(channel,
        options: CallOptions(timeout: Duration(seconds: 20)));
  }

  Future<void> connectEnd() async {
    await channel.shutdown();
  }

  void _updateTrustPeopleList() async {
    print("updatelist");
    connectStart();
    var allUserNames = UserName();
    try {
      allUserNames = await stub.GetAllUserNames();
      print("pass get ");
      print(allUserNames);
    } catch (e) {}

    final usernameString = allUserNames.usernames;
    print(usernameString);
  }

  Widget _buildListView(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
                itemCount: trustedUser.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: new Text(trustedUser[index]),
                    subtitle: Text("subtitle"),
                    leading: Icon(Icons.people),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print("work");
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider();
                })),
        RaisedButton(
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
