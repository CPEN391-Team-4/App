//import 'dart:html';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTrustPeopleScreen extends StatefulWidget {
  AddTrustPeopleScreen({Key key}) : super(key: key);
  @override
  _AddTrustPeopleScreenState createState() => new _AddTrustPeopleScreenState();
}

class _AddTrustPeopleScreenState extends State<AddTrustPeopleScreen> {
  File _image;
  final picker = ImagePicker();

  String valuechoose;
  List listitem = ["limit access", "free access"];
  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    //final image = await ImagePicker.
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print("No Image Select!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AddTrustPeople"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    hintText: "Add People's Name",
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.accessibility)),
                keyboardType: TextInputType.name,
                obscureText: false,
                maxLength: 20,
              ),

              Center(
                child: _image == null
                    ? Text("Can't load image.")
                    : Image.file(_image),
              ),

              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Add Photo",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
              ),
              Positioned(
                  // top: 100,
                  // right: 50.0,
                  child: FloatingActionButton(
                onPressed: getImage,
                child: Icon(Icons.camera_alt),
              )),

              SizedBox(
                height: 50,
              ),
              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Add This Person",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
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
                      });
                    }),
              )

              //trustedPeoplePhoto(),
            ],
          ),
        ));
  }

//   void uploadpicture(ImageSource source)async {

// }

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
