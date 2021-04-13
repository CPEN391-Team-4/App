import 'package:flutter/material.dart';
import 'addUser.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'eachTrustedUser.dart';
import 'connect.dart';

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
  void initState() {
    _updateTrustPeopleList();
  }

// built a user page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildListView(context),
      ),
    );
  }

  Future<void> connectEnd() async {
    await channel.shutdown();
  }

  Future<void> _updateTrustPeopleList() async {
    //print("updatelist");
    final ret = await connectStart(15);
    stub = ret[0];
    channel = ret[1];

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

// built a list of view of the trusted user on the user page
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
                    //subtitle: Text("subtitle"),
                    leading: Icon(Icons.people),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print("work");
                      //every trusted user entry will leads to a unique page for each trusted user.
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
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
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
