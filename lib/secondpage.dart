import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Secondpage extends StatelessWidget { ///Defining variable to receive passed values from first page here
  final String msg1;
  final String msg2;
  final String msg3;
  final String msg4;
  final String msg5;
  final String msg6;
  final String msg7;
  final image;
  var msg8;
  var msg9;
  Secondpage(  ///Receiving passed values from first page here
      {required this.msg1,
      required this.msg2,
      required this.msg3,
      required this.msg4,
      required this.msg5,
      required this.msg6,
      required this.msg7,
      required this.msg8,
      required this.msg9,
      required this.image});

  Future<void> sendDataToServerRight() async { /*This function is defined to take positive feedback from users.
                                               *And it update the feedback count to the database
                                               */
    msg8 = msg8 + 1;
    msg9 = msg9;
    var msg10 = msg3;
    final response = await http.post(
      Uri.parse('https://mpd.icfoss.org//update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'msg8': msg8,'msg9': msg9, 'label': msg10}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send data');
    }
  }

  Future<void> sendDataToServerWrong() async { /*This function is defined to take negative feedback from users.
                                               *And it update the feedback count to the database
                                               */
    msg9 = msg9 + 1;
    msg8 = msg8;
    var msg10 = msg3;
    final response = await http.post(
      Uri.parse('https://mpd.icfoss.org//update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'msg8': msg8,'msg9': msg9, 'label': msg10}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send data');
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold( ///Creating second page Scaffold widget here
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("PLANT DETAILS"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 10.00,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: SingleChildScrollView( /// Scrollable widget for display the details of predicted plant
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width,
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Text(
                "SCIENTIFIC NAME",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg1, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "MALAYALAM NAME",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg2, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "ENGLISH NAME",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg3, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "COMMON NAME",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg4, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "USEFUL PARTS",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg5, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "MEDICINAL USE",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(msg6, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 40,
              ),
              Text(
                "PLANT DESCRIPTION",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                msg7,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 40,
              ),
              Row( /// Row widget is used here to setup buttons for counting feedback.
                children: [
                  ElevatedButton( ///First elevated button to count positive feedback
                    onPressed: () {
                      sendDataToServerRight();
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog( ///Pop up message box
                                title: Text('Thanks!'),
                                content: Text("Your response is updated"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Go back",
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ))
                                ],
                              ));
                    },
                    child: Icon(Icons.thumb_up),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size(195, 55),
                        backgroundColor: Colors.orange),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  ElevatedButton( ///Second elevated button to count negative feedback
                      onPressed: () {
                        sendDataToServerWrong();
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog( ///Pop up message box
                                  title: Text('Thanks!'),
                                  content: Text("Your response is updated"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          color: Colors.green,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("Go back",
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                        ))
                                  ],
                                ));
                      },
                      child:  Icon(Icons.thumb_down),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size(195, 55),
                        backgroundColor: Colors.orange,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
