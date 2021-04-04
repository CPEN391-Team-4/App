import 'dart:ffi';

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';
import 'users.dart';
import 'connect.dart';
import 'eachRecord.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => new _HistoryState();
}



class _HistoryState extends State<History> {
<<<<<<< HEAD
=======
  var channel;
  var stub;
  List<HistoryRecord> historyrecords = [];
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Users'),
=======
        title: Text('History Records'),
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildListView(context),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
<<<<<<< HEAD
                itemCount: trustedUser.length,
                itemBuilder: (_, index) {
                  final username = trustedUser[index];
                  return ListTile(
                    title: new Text(trustedUser[index]),
                    subtitle: Text("subtitle"),
=======
                itemCount: historyrecords.length,
                itemBuilder: (_, index) {
                  final username = historyrecords[index].name;
                  final status = historyrecords[index].status;
                  final time = historyrecords[index].time;
                  final image_uuid = historyrecords[index].imageLocation;
                  return ListTile(
                    title: new Text(username),
                    subtitle: Text(time),
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
                    leading: Icon(Icons.people),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print("work");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
<<<<<<< HEAD
                              builder: (context) => EachUserScreen(
                                    userName: username,
=======
                              builder: (context) => EachrecordScreen(
                                    userName: username,
                                    statu: status,
                                    accesstime: time,
                                    image_address: image_uuid,
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
                                  )));
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider();
                })),
        TextButton(
          child: Text(
<<<<<<< HEAD
            "Add Users",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUserScreen()));
          },
=======
            "Get Records",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () =>
              getHistoryRecord("2021-01-02 03:04:05", "2021-04-02 03:04:05"),
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
        ),
      ],
    );
  }
<<<<<<< HEAD
=======

  Future<Void> getHistoryRecord(String timestart, String timeend) async {
    final ret = await connectStart();
    stub = ret[0];
    channel = ret[1];

    try {
      var timestamp = Timestamp()
        ..starttime = timestart
        ..endtime = timeend;
      var records = await stub.getHistoryRecorded(timestamp);
      //print(records);

      setState(() {
        historyrecords = records.record;
        //print(historyrecords);
      });
    } catch (e) {
      print(e);
      print("Can not get all the records.");
    }
    connectEnd();
  }

  Future<void> connectEnd() async {
    await channel.shutdown();
  }
>>>>>>> cace718f6610acbe3eb314ef7b442fe1379f2691
}
