// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;

import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:shh19/utils/pavol_api.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;
  String _value;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    DetectSend detect = new DetectSend(image: image);

    //detect.sendRequest();
    Map<String, dynamic> valueJson = jsonDecode(detect.sendRequest());
    print(valueJson);
    _value = valueJson['data']['glucoseValue'];

    setState(() {
      _image = image;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: _value != null
                    ? Text(_value)
                    : Center(child: CircularProgressIndicator())
              /*child: Transform.rotate(
                angle: 90 * pi / 180,
                child: _image == null
                    ? Center(child: CircularProgressIndicator())
                    : Image.file(_image),
              ),*/
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Container(
                        height: double.infinity,
                        child: RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          onPressed: getImage,
                          child: const Text('Přehrát',
                            style: TextStyle(fontSize: 30, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                      flex: 5,
                      child: Container(
                        height: double.infinity,
                        child: RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          onPressed: getImage,
                          child: const Text('Přehrát pomaleji',
                            style: TextStyle(fontSize: 30, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(''),
            ),
            Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color.fromRGBO(245, 230, 228, 1),
                    onPressed: getImage,
                    child: const Text('Vyfotit znovu',
                      style: TextStyle(fontSize: 50, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ),

          ]
      ),
    );

  }
}
