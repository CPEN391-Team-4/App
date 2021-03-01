import 'dart:async';
import 'dart:io';
// import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/protobuf/TrustPeople.pbgrpc.dart';
// import 'package:grpc/grpc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:protobuf/protobuf.dart' as $pb;

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => new _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  File _image;
  final picker = ImagePicker();

  bool sendResult;
  String _name;

  String _accessType;
  List listitem = ["Unrestricted", "Restricted"];

  void _setName(String name) {
      setState(() {
          _name = name;
      });
  }

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    //final image = await ImagePicker.
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
                title: Text("Add a User"),
                centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
                setImage(_image),
                SizedBox(height:10),
                Positioned(
                        // top: 100,
                        // right: 50.0,
                        child: FloatingActionButton(
                                onPressed: getImage,
                                child: Icon(Icons.camera_alt),
                        )),

                Padding(
                        padding: const EdgeInsets.all(16.0),

                        child:  TextField(
                                onChanged: (text) {
                                    _setName(text);
                                },
                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                    labelText: 'Name',
                                            )
                        ),

                ),

              Center(
                child: DropdownButton(
                    hint: Text("User Access Type"),
                    focusColor: Colors.green,
                    dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    isExpanded: false,
                    value: _accessType,
                    items: listitem.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (newItem) {
                      setState(() {
                          _accessType = newItem;
                      });
                    }),
              ),


            ],
          ),
        ));

  }


  Widget setImage(File file) {
      if (file == null) {
          return new Container(
                  width: 250.0,
                  height: 250.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                          image: DecorationImage(
                                  image: AssetImage('assets/profile.png')
                          )
                  )
          );
      }
      else {
          return new Container(
                  width: 250.0,
                  height: 250.0,
                  alignment: Alignment.center,
                  child: Image.file(file)
          );

      }
  }


}


Widget trustedPeoplePhoto() {
  return Center(
    child: Stack(
      children: <Widget>[
        Positioned(
            top: 100,
            right: 50.0,
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 28,
            )),
      ],
    ),
  );
}

Future<bool> AddTrustPeople() async {
  // print("Add people");

  // final channel = ClientChannel('192.168.0.104',
      // port: 9000,
      // options:
          // const ChannelOptions(credentials: ChannelCredentials.insecure()));

  // final stub = RouteClient(channel,
      // options: CallOptions(timeout: Duration(seconds: 10)));

  // final imageDatalist = new List<int>.generate(100, (i) => i + 1);

  // final userName = "Brendon";
  // print(imageDatalist);
  // Stream<User> generateReqStream(int size, int chunksize) async* {
    // for (int i = 0; i < size / chunksize; i++) {
      // final photo = Photo()
        // ..image =
            // imageDatalist.sublist(i * chunksize, i * chunksize + chunksize);
      // print(photo.image);
      // final request = User()
        // ..name = userName
        // ..image = photo;
      // yield request;
    // }
  // }

  // try {
    // var response = await stub.addTrustedUser(generateReqStream(100, 20));
    // if (response.status == 1) {
      // print("The User was add successfully.");
      // await channel.shutdown();
      // return true;
    // }
  // } catch (e) {
    // print('Caught error: $e');
  // }

  // await channel.shutdown();
  // print("Add User failed.");
  return false;
}

Future<bool> RemoveTrustedUser() async {
  // print("Remove User");
  // final channel = ClientChannel('192.168.0.104',
      // port: 9000,
      // options:
          // const ChannelOptions(credentials: ChannelCredentials.insecure()));

  // final stub = RouteClient(channel,
      // options: CallOptions(timeout: Duration(seconds: 10)));

  // final userName = "Brendon";
  // final deleteRequest = User()..name = userName;
  // try {
    // var response = await stub.removeTrustedUser(deleteRequest);
    // if (response.status == 1) {
      // await channel.shutdown();
      // return true;
    // }
  // } catch (e) {
    // print('Caught error: $e');
  // }
  // await channel.shutdown();
  return false;
}
