// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;

import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistika'),
      ),
      body: Container(
        child: _image == null
            ? Text('No photo selected.')
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
