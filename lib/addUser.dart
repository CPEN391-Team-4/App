import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'users.dart';

class AddUserScreen extends StatefulWidget {
  //it need to pass in two more arguments in, when the user is alrady there
  // the in = 1, also when click a old user, it will pass in the username
  @override
  _AddUserScreenState createState() => new _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final alreadyExist = true; // need to pass from the prepage
  final userId = "1"; //need to pass from the prepage

  var channel;
  var stub;
  var userName;
  var Restricted;
  final usernameText = new TextEditingController();

  File _image;

  final picker = ImagePicker();

  Image showingimage;

  bool sendResult;

  String _accessType;

  String valuechoose;
  List listitem = ["limit access", "free access"];
  Future getImage(int source) async {
    var image = PickedFile("");
    if (source == 1) {
      image = await picker.getImage(source: ImageSource.gallery);
    } else if (source == 0) {
      image = await picker.getImage(source: ImageSource.camera);
    }

    //final image = await ImagePicker.
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print(_image);
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
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              setImage(_image),
              SizedBox(height: 10),
              TextButton(
                // textColor: Colors.white,
                // color: Colors.blue,
                child: Text(
                  "Add Photo",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => getImage(1),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text("or"),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                icon: new Icon(Icons.camera_alt),
                onPressed: () => getImage(0),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: usernameText,
                decoration: InputDecoration(
                    hintText: "Enter User's Name",
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.accessibility)),
                keyboardType: TextInputType.name,
                obscureText: false,
                maxLength: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: DropdownButton(
                    hint: Text("Select Items: "),
                    focusColor: Colors.green,
                    dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    isExpanded: false,
                    value: valuechoose,
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // add new choice button
                      setState(() {
                        valuechoose = newValue;
                        if (valuechoose == "limit access") {
                          Restricted = true;
                        } else {
                          Restricted = false;
                        }
                      });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                // textColor: Colors.white,
                // color: Colors.blue,
                child: Text(
                  "Add User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() {
                  setState(() {
                    userName = usernameText.text;
                  });
                  if (_image == null ||
                      userName == null ||
                      Restricted == null) {
                    print("Lack of information");
                  } else {
                    AddTrustPeople(_image, userName, showingimage, Restricted);
                  }
                }),
              ),
            ],
          ),
        ));
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

  Future<bool> AddTrustPeople(
      File image, String username, Image showimage, bool restricted) async {
    print("Add people");
    print(userName);
    connectStart();

    final imageBytes = await image.readAsBytes();

    print(imageBytes.length);
    print(channel);
    print(stub);
    try {
      Stream<User> requestStream = generateReqStream(
          imageBytes, imageBytes.length, 400, username, restricted);
      var response = await stub.addTrustedUser(requestStream);
      var users = Users();
      // users._updateTrustPeopleList();
    } catch (e) {
      print('Caught error: $e');
      connectEnd();
      return false;
    }

    //await channel.shutdown();
    connectEnd();
    print("Add User success.");

    return true;
  }

  Stream<User> generateReqStream(List imageBytes, int size, int chunksize,
      String username, bool restricted) async* {
    print("Generate Stream.");
    var cursize = 0;
    while (cursize < size) {
      var photo;
      if (cursize + chunksize >= size) {
        photo = Photo()
          ..image = imageBytes.sublist(cursize, size)
          ..fileExtension = "jpg";
        cursize = size;
      } else {
        photo = Photo()
          ..image = imageBytes.sublist(cursize, cursize + chunksize)
          ..fileExtension = 'jpg';
        cursize += chunksize;
      }
      final request = User()
        ..name = username
        ..restricted = restricted
        ..photo = photo;
      yield request;
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

  Widget setImage(File file) {
    if (file == null) {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/profile.png'))));
    } else {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          child: Image.file(file));
    }
  }
}
