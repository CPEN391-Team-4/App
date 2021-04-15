import 'dart:io' as io;
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app/home_widget.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'package:grpc/grpc.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'connect.dart';

class EachUserScreen extends StatefulWidget {
  //it need to pass in two more arguments in, when the user is alrady there
  // the in = 1, also when click a old user, it will pass in the username

  String userName;
  EachUserScreen({Key key, @required this.userName}) : super(key: key);
  @override
  _EachUsersState createState() => new _EachUsersState(userName);
}

class _EachUsersState extends State<EachUserScreen> {
  var stub;
  var channel;
  String userName;
  File _image;
  final picker = ImagePicker();
  bool Restricted;
  String valuechoose;
  List listitem = ["limit access", "free access"];
  var imgAsBytes = null;

  @override
  void initState() {
      // Automatically get the user image when the page is first built
    getUserImage(userName);
  }

  // Function that gets an image from the camera or photo
  // gallery when the user wants to update the picture
  Future getImage(int source) async {
    var image = PickedFile("");
    if (source == 1) {
      image = await picker.getImage(source: ImageSource.gallery);
    } else if (source == 0) {
      image = await picker.getImage(source: ImageSource.camera);
    }

    setState(() {
      if (image != null) {
        _image = File(image.path);
        imgAsBytes = null;
      } else {
        print("No Image Selected");
      }
    });
  }

  _EachUsersState(this.userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userName),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: <Widget>[
              setImage(_image),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: Text(
                  "Device Storage.",
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
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: Text(
                  "Update User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() {
                  UpdateUserPhoto(userName, _image);
                }),
              ),

              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                child: Text(
                  "Delete User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  RemoveTrustedUser(userName);
                },
              ),
            ])));
  }

  Future<void> connectEnd() async {
    await channel.shutdown();
  }

  // Funtion that makes a GRPC call to remove this user
  // when the remove button is called.
  Future<bool> RemoveTrustedUser(String username) async {
    print("Remove User");
    final ret = await connectStart(10);
    stub = ret[0];
    channel = ret[1];

    final deleteRequest = User()..name = username;
    try {
      var response = await stub.removeTrustedUser(deleteRequest);
    } catch (e) {
      print('Caught error: $e');
      connectEnd();
      return false;
    }
    //await channel.shutdown();
    connectEnd();
    return false;
  }

  // Function called when update button is pressed to update the photo
  // of the current user
  Future<bool> UpdateUserPhoto(String username, File image) async {
    print("Update user photo");
    print(username);
    final ret = await connectStart(20);
    stub = ret[0];
    channel = ret[1];

    final imageBytes = await image.readAsBytes();
    print(imageBytes.length);
    try {
      var response = await stub.updateTrustedUser(generateReqStream(
          imageBytes, imageBytes.length, 400, username, true));
    } catch (e) {
      print('Caught error: $e');
      connectEnd();
      return false;
    }

    connectEnd();
    return true;
  }

  // Creates a stream from the photo in accordance with GRPC streaming
  // guidlines
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
          ..fileExtension = "jpg";
        cursize += chunksize;
      }
      final request = User()
        ..name = username
        ..restricted = true
        ..photo = photo;
      yield request;
    }
  }

  // Function that gets the image of the user from the backend by
  // making a GRPC call. It then stores this image in memory and 
  // appropriately changes the state of the page so that
  // this image can be displayed in the app. 
  // Note: This will clear the image cache.
  Future<File> getUserImage(String username) async {
    setState(() {
      _image = null;
    });
    final ret = await connectStart(25);
    stub = ret[0];
    channel = ret[1];

    var imageBytes = BytesBuilder();

    final user = User()..name = username;

    try {
      await for (var returnUser in stub.getUserPhoto(user)) {
        imageBytes.add(returnUser.image);
      }
      print("Created");
      // Clear image cache
      imageCache.clear();

      setState(() {
        imgAsBytes = imageBytes.toBytes();
      });
    } catch (e) {
      print(e);
    }
    connectEnd();
  }

  // Responsive function that displays an image on the page
  // based on the state of imgAsBytes and file
  Widget setImage(File file) {
    if (imgAsBytes != null) {
      return new Container(
          width: 250.0,
          height: 250.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              image: DecorationImage(image: MemoryImage(imgAsBytes))));
    }

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
