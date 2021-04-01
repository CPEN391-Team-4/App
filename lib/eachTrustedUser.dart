import 'dart:io';

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
    print(username);
    var imageBytes = [];

    final user = User()..name = username;

    try {
      await for (var returnUser in stub.getUserPhoto(user)) {
        //print(returnUser);
        imageBytes += returnUser.image;
      }
      List<int> imagelist = imageBytes.map((s) => s as int).toList();
      print(imagelist.length);
      final dir = await getApplicationDocumentsDirectory();
      File image_file = new File(dir.path + "/test.jpg");

      print(imagelist);
      await image_file.writeAsBytes(imagelist);
      setState(() {
        _image = image_file;
      });

    } catch (e) {
      print(e);
    }
    connectEnd();
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

// class Storage {
//   Future<String> get localPath async {
//     final dir = await getApplicationDocumentsDirectory();
//     return dir.path;
//   }

//   Future<File> get localFile async {
//     final path = await localPath;
//     return File('$path/tester.jpg');
//   }

//   Future<List<int>> readData() async {
//     try {
//       final file = await localFile;
//       var body = await file.readAsBytes();

//       return body;
//     } catch (e) {
//       return e;
//     }
//   }

//   Future<File> writeData(List<int> data) async {
//     final file = await localFile;
//     return file.writeAsBytes(data);
//   }
// }
