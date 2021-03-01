import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/protobuf/TrustPeople.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<String> _getUserNameFromSharePref(String userid) async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(userid);
    if (userName == null) {
      print("Not exists.");
      return "";
    } else {
      print(userName);
    }
  }

  Future<Void> _putUserNameToSharePref(String username) async {
    print("put into prefs");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("4", username);
  }

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

              // Center(
              //   child: _image == null
              //       ? Text("Please upload an Image.")
              //       : Image.file(_image),
              // ),

              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
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

              // Center(
              //   child: showingimage == null
              //       ? Text("Not Showing Picture.")
              //       : showingimage,
              // ),
              // SizedBox(
              //   height: 20,
              // ),

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

              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
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

              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Update User Image",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (() {
                  setState(() {
                    userName = usernameText.text;
                  });
                  //UpdateUserPhoto(userName, _image);
                }),
              ),

              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Delete User",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  RemoveTrustedUser("");
                },
              ),
              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "testget",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _getUserNameFromSharePref("1");
                },
              ),
              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "testadd",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _putUserNameToSharePref("testBrendon4");
                },
              ),

              // showingimage,
            ],
          ),
        ));
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

  // Future<bool> getUserImage(String username) {
  //   connectStart();
  //   var imageBytes;

  //   Image returnimage = Image.memory(imageBytes);

  //   setState(() {
  //     if (returnimage != null) {
  //       showingimage = returnimage;
  //     } else {
  //       print("Not update yet");
  //     }
  //   });

  //   connectEnd();
  // }

  Future<bool> RemoveTrustedUser(String username) async {
    print("Remove User");
    connectStart();

    final deleteRequest = User()..name = "mergetest";
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
    connectStart();

    final imageBytes = await image.readAsBytes();
    print(imageBytes.length);
    try {
      var response = await stub.addTrustedUser(generateReqStream(
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
          ..fileExtension = ".jpg";
        cursize = size;
      } else {
        photo = Photo()
          ..image = imageBytes.sublist(cursize, cursize + chunksize);
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

// Future<File> urlToFile(String imageUrl) async {
// // generate random number.
//   var rng = new Random();
// // get temporary directory of device.
//   Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//   String tempPath = tempDir.path;
// // create a new file in temporary path with random file name.
//   File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.jpg');
// // call http.get method and pass imageUrl into it to get response.
//   http.Response response = await http.get(imageUrl);
// // write bodyBytes received in response to file.
//   await file.writeAsBytes(response.bodyBytes);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//   return file;
// }
