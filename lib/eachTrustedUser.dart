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
                // textColor: Colors.white,
                // color: Colors.blue,
                child: Text(
                  "Get from Phone.",
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
              TextButton(
                // textColor: Colors.white,
                // color: Colors.blue,
                child: Text(
                  "Update User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() {
                  UpdateUserPhoto(userName, _image, Restricted);
                }),
              ),
              TextButton(
                // textColor: Colors.white,
                // color: Colors.blue,
                child: Text(
                  "Get Image",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() {
                  getUserImage(userName);
                }),
              ),
              TextButton(
                // textColor: Colors.white,
                // color: Colors.blue,
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

  Future<bool> RemoveTrustedUser(String username) async {
    print("Remove User");
    final ret = await connectStart();
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

  Future<bool> UpdateUserPhoto(
      String username, File image, bool restricted) async {
    print("Update user photo");
    print(username);
    final ret = await connectStart();
    stub = ret[0];
    channel = ret[1];

    final imageBytes = await image.readAsBytes();
    print(imageBytes.length);
    try {
      var response = await stub.updateTrustedUser(generateReqStream(
          imageBytes, imageBytes.length, 400, username, restricted));
    } catch (e) {
      print('Caught error: $e');
      connectEnd();
      return false;
    }

    connectEnd();
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
          ..fileExtension = "jpg";
        cursize += chunksize;
      }
      final request = User()
        ..name = username
        ..restricted = restricted
        ..photo = photo;
      yield request;
    }
  }

  Future<File> getUserImage(String username) async {
    setState(() {
      _image = null;
    });
    final ret = await connectStart();
    stub = ret[0];
    channel = ret[1];

    var imageBytes = BytesBuilder();

    final user = User()..name = username;

    // final dir = await getApplicationDocumentsDirectory();
    // final imgDir = Directory(dir.path + "/userImages/");
    // if (!await imgDir.exists()) {
    // await imgDir.create(recursive: true);
    // print("Made");
    // }
    // File image_file = new File(imgDir.path + "user.jpg");
    // String imgPath = imgDir.path + "user.jpg";
    // if (await File(imgPath).exists()) {
    // print("Deleted");
    // await File(imgPath).delete();
    // }

    try {
      await for (var returnUser in stub.getUserPhoto(user)) {
        imageBytes.add(returnUser.image);
      }
      print("Created");

      // await File(imgPath).create();
      // File imgFile = File(imgPath);
      // imgFile.writeAsBytesSync(imageBytes.toBytes());

      imageCache.clear();

      setState(() {
        // _image = imgFile;
        imgAsBytes = imageBytes.toBytes();
      });
    } catch (e) {
      print(e);
    }
    connectEnd();
  }

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
