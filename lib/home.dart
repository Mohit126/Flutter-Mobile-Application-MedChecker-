import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:plant_inn/secondpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image; /// Declaring variables here
  String output1 = "";
  String output2 = "";
  String output3 = "";
  String output4 = "";
  String output5 = "";
  String output6 = "";
  String output7 = "";
  String msg = "";
  int output8 = 0;
  int output9 = 0;

    Future getImage(ImageSource source) async { ///Defining function to take image from camara or gallery
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 100,
      );
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future<void>uploadImage() async { ///Uploading image captured or taken image from gallery to server through http MultipartRequest
    final request = http.MultipartRequest(
        'POST', Uri.parse('https://mpd.icfoss.org/upload'));
    final headers = {'Content-type': 'multipart/form-data'};
    request.files.add(http.MultipartFile(
        'image', _image!.readAsBytes().asStream(), _image!.lengthSync(),
        filename: _image!.path.split('/').last));
    request.headers.addAll(headers);

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);

    setState(() { /// In the setState, it received the details of predicted class from the database
      if (resJson['msg'] != '') {
        msg = resJson['msg'];
      } else {
        output1 = resJson['output1'];
        output2 = resJson['output2'];
        output3 = resJson['output3'];
        output4 = resJson['output4'];
        output5 = resJson['output5'];
        output6 = resJson['output6'];
        output7 = resJson['output7'];
        output8 = resJson['output8'];
        output9 = resJson['output9'];
        gotoSecondScreen();
      }
    });
  }

  gotoSecondScreen() async { ///This function is to pass the received values to the next page(secondpage.dart) for displaying it.
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) {
        return Secondpage(
            msg1: output1,
            msg2: output2,
            msg3: output3,
            msg4: output4,
            msg5: output5,
            msg6: output6,
            msg7: output7,
            msg8: output8,
            msg9: output9,
            image: _image);
      }),
    );
  }

  changeText() { /// This function is for clearing the text displayed on the first screen about 'The class is not present' when user click to take new image
    setState(() {
      msg = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold( ///Creating user interface with Scaffold widget here
      appBar: AppBar(
          title: Center(
              child: Text(
                'Find Your Medicinal Plant',
                style: TextStyle(color: Colors.white),
              )),
          backgroundColor: Colors.orange),
      body: LayoutBuilder( ///LayoutBuilder widget to create a responsive design based on the dimensions of the screen
        builder: (BuildContext context, BoxConstraints constraints) { return Stack(
        children: [
          Positioned( ///First positioned box to display image
              height: size.height * 0.5,
              width: size.width,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (_image != null)
                        ? FileImage(_image!) as ImageProvider
                        : AssetImage("assets/image.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Positioned( ///Second positioned box to showing the buttons and display page
            top: size.height * 0.45,
            height: size.height * 0.50,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(msg, /// This text field for showing message if the predicted class is not present
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 80,
                  ),
                  Row( ///In the row container buttons are defined
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Column(
                        children: [
                          OutlinedButton(/// Pick image from camara, using the defined button
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(24),
                            ),
                            onPressed: () async {
                              getImage(ImageSource.camera);
                              changeText();
                            },
                            child: Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Column(///Pick image from gallery, using the defined button
                        children: [
                          OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(24),
                            ),
                            onPressed: () async {
                              getImage(ImageSource.gallery);
                              changeText();
                            },
                            child: Icon(
                              Icons.photo,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Gallery',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Column( ///Predict button, to upload image and take response from server
                        children: [
                          OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(24),
                            ),
                            onPressed: () async {
                              uploadImage();
                            },
                            child: Icon(
                              Icons.search,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Predict',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );},)
    );
  }
}