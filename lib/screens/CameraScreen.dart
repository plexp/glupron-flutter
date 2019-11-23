// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;

import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:shh19/utils/pavol_api.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    DetectSend detect = new DetectSend(image: image);

    detect.sendRequest();

    setState(() {
      _image = image;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Container(
        child: _image == null
            ? Center(child: CircularProgressIndicator())
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Take Image',
        child: Icon(Icons.add_a_photo),
      ),
    );

  }
}
