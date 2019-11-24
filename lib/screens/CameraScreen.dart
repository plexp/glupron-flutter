// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shh19/utils/pavol_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  String localFilePath;

  File _sound;
  String _text;
  String _value;

  Future<String> getLanguage() async {
    var preferences = await SharedPreferences.getInstance();

    return preferences.getString('language');
  }

  List<String> switchLanguage(){
    String language;
    getLanguage().then((value) {
      language = value;
    });

    switch(language) {
      case 'CZ': {
        return ['Přehrát', 'Přehrát pomaleji', 'Vyfotit znovu'];
      }
      case 'EN': {
        return ['Play', 'Play slower', 'Take again'];
      }
      default: {
        return ['Přehrát', 'Přehrát pomaleji', 'Vyfotit znovu'];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    String language;
    getLanguage().then((value) {
      language = value;
    });

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    DetectSend detect = new DetectSend(image: image);

    var response = await detect.sendRequest(language);


    Map<String, dynamic> jsonP = json.decode(response);

    DetectResponse detectResponse = new DetectResponse.fromJson(jsonP);

    await detectResponse.processSound();

    setState(() {
      _value = detectResponse.getValue();
      _sound = detectResponse.getSound();
      _text = detectResponse.getText();
    });
    advancedPlayer.play(this._sound.path, isLocal: true);
  }

  Widget build(BuildContext context) {
    List<String> texts = switchLanguage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: _value != null
                    ? Column(
                children: <Widget>[Expanded(
                  flex: 1,
                  child: Text(_value, style: TextStyle(fontSize: 70.0),)
                ),
                  Expanded(
                      flex: 1,
                      child: Text(_text, style: TextStyle(fontSize: 30.0),)
                  )],
              )
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
                        child: this._sound == null
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          onPressed: () => advancedPlayer.play(this._sound.path, isLocal: true),
                          child: Text(texts[0],
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
                        child: this._sound == null
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          onPressed: () => audioCache.play(this._sound.path),
                          child: Text(texts[1],
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
                    child: Text(texts[2],
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
