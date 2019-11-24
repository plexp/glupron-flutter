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
  String _value;
  List<String> _texts;

  Future<String> getLanguage() async {
    var preferences = await SharedPreferences.getInstance();

    return preferences.getString('language');
  }

  void switchLanguage() async{
    String language = await getLanguage();
    List<String> text;
    switch(language) {
      case 'CZ': {
        text = ['Přehrát', 'Vyfotit znovu', 'Zpět do menu'];
        break;
      }
      case 'EN': {
        text = ['Play', 'Take again', 'Back to menu'];
        break;
      }
      default: {
        text = ['Přehrát', 'Vyfotit znovu', 'Zpět do menu'];
      }
    }

    setState(() {
      _texts = text;
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
    switchLanguage();
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
    });
    advancedPlayer.play(this._sound.path, isLocal: true);
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
                    ? Center(child: Text(_value, style: TextStyle(fontSize: 90.0),textAlign: TextAlign.center,),)
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
                          child: _texts[0] == null
                              ? Center(child: CircularProgressIndicator())
                              : Text(_texts[0],
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
                          child: _texts[1] == null
                              ? Center(child: CircularProgressIndicator())
                              : Text(_texts[1],
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: _texts[2] == null
                    ? Center(child: CircularProgressIndicator())
                    : Text(_texts[2],
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
