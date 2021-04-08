import 'dart:ffi';
import 'package:intl/intl.dart';
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
  var channel;
  var stub;
  DateTime fromTime = DateTime.now();
  DateTime toTime = DateTime.now();

  List<HistoryRecord> historyrecords = [];
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('History Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildListView(context, _width),
      ),
    );
  }

  void _selectFromDate() async {
      final DateTime pickedDate = await showDatePicker(
              context: context,
              initialDate: fromTime,
              firstDate: DateTime(2015),
              lastDate: DateTime(2150));
      if (pickedDate != null)
          setState(() {
              fromTime = pickedDate;
          });
  }

  void _selectToDate() async {
      final DateTime pickedDate = await showDatePicker(
              context: context,
              initialDate: toTime,
              firstDate: DateTime(2015),
              lastDate: DateTime(2150));
      if (pickedDate != null)
          setState(() {
              toTime = pickedDate;
          });
  }
  Widget _buildListView(BuildContext context, _width) {
    return Column(
      children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Container(
                            child: Column(
                                    children: [
                                        Center(child:Text("From:"),),
                                        Row(
                                                children: [
                                                    RaisedButton(
                                                            onPressed: _selectFromDate,
                                                            child: Row(
                                                                    children: [
                                                                        Text(DateFormat.yMMMd().format(fromTime)),
                                                                        SizedBox(width:3),
                                                                        Icon(
                                                                                Icons.calendar_today
                                                                        ),
                                                                    ],
                                                            ),
                                                    ),
                                                ],

                                        ),

                                    ],
                            ),
                    ),
                  SizedBox(width: 20),
                    Container(
                            child: Column(
                                    children: [
                                        Center(child:Text("To:"),),
                                        Row(
                                                children: [
                                                    RaisedButton(
                                                            onPressed: _selectToDate,
                                                            child: Row(
                                                                    children: [
                                                                        Text(DateFormat.yMMMd().format(toTime)),
                                                                        SizedBox(width:3),
                                                                        Icon(
                                                                                Icons.calendar_today
                                                                        ),
                                                                    ],
                                                            ),
                                                    ),
                                                ],

                                        ),

                                    ],
                            ),
                    ),
                ],
              ),
            ),
        TextButton(
          child: Text(
            "Get Records",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () =>
              getHistoryRecord("2021-01-02 03:04:05", "2021-04-02 03:04:05"),
        ),
        Expanded(
            child: ListView.separated(
                itemCount: historyrecords.length,
                itemBuilder: (_, index) {
                  final username = historyrecords[index].name;
                  final status = historyrecords[index].status;
                  final time = historyrecords[index].time;
                  final image_uuid = historyrecords[index].imageLocation;
                  return ListTile(
                    title: new Text(username),
                    subtitle: Text(time),
                    leading: Icon(Icons.people),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print("work");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EachrecordScreen(
                                    userName: username,
                                    statu: status,
                                    accesstime: time,
                                    image_address: image_uuid,
                                  )));
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider();
                })),
      ],
    );
  }

  Future<Void> getHistoryRecord(String timestart, String timeend) async {
    final ret = await connectStart();
    stub = ret[0];
    channel = ret[1];
    var to = DateFormat('yyyy-MM-dd').format(toTime.add(Duration(hours: 24)));
    var from = DateFormat('yyyy-MM-dd').format(fromTime);
    to = to + " 00:00:00";
    from = from + " 00:00:00";

    try {
      var timestamp = Timestamp()
        ..starttime = from
        ..endtime = to;
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
}
