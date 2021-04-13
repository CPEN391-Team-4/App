import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'users.dart';
import 'connect.dart';

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
  final usernameText = new TextEditingController();

  File _image;

  final picker = ImagePicker();

  Image showingimage;

  bool sendResult;

  String _accessType;

  String valuechoose;

// get image from the device gallery or take a picture directly from the camera
  Future getImage(int source) async {
    var image = PickedFile("");
    if (source == 1) {
      image = await picker.getImage(source: ImageSource.gallery);
    } else if (source == 0) {
      image = await picker.getImage(source: ImageSource.camera);
    }
    // update the picture show on the page
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print(_image);
      } else {
        print("No Image Selected");
      }
    });
  }

//build the whole add trusted page
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
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
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
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen)),
                child: Text(
                  "Add User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() async {
                  setState(() {
                    userName = usernameText.text;
                  });
                  if (_image == null || userName == null) {
                    print("Lack of information");
                  } else {
                    await AddTrustPeople(_image, userName, showingimage);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Users()));
                  }
                }),
              ),
            ],
          ),
        ));
  }

//end the gprc connection with server
  Future<void> connectEnd() async {
    await channel.shutdown();
  }

// add a trusted user into the server
  Future<bool> AddTrustPeople(
      File image, String username, Image showimage) async {
    print("Add people");
    print(userName);
    final ret = connectStart(20);
    stub = ret[0];
    channel = ret[1];

    final imageBytes = await image.readAsBytes();

    print(imageBytes.length);
    print(channel);
    print(stub);
    try {
      Stream<User> requestStream =
          generateReqStream(imageBytes, imageBytes.length, 400, username, true);
      var response = await stub.addTrustedUser(requestStream);
      var users = Users();
    } catch (e) {
      print('Caught error: $e');
      connectEnd();
      return false;
    }

    connectEnd();
    print("Add User success.");

    return true;
  }

// generate a stream to send the user image into the server.
  Stream<User> generateReqStream(List imageBytes, int size, int chunksize,
      String username, bool restricted) async* {
    print("Generate Stream.");
    var cursize = 0;
    while (cursize < size) {
      var photo;
      if (cursize + chunksize >= size) {
        photo = Photo()
          ..image = imageBytes.sublist(cursize, size)
          ..fileExtension = "jpeg";
        cursize = size;
      } else {
        photo = Photo()
          ..image = imageBytes.sublist(cursize, cursize + chunksize)
          ..fileExtension = 'jpeg';
        cursize += chunksize;
      }
      final request = User()
        ..name = username
        ..restricted = true
        ..photo = photo;
      yield request;
    }
  }

// set the image in the app page
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
