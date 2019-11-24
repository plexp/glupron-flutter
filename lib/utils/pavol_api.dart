import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;


class DetectSend {
  File image;
  String body;

  DetectSend({this.image});

  Future<String> _imageToBase64(image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<List<int>> _imageToBytes(image) async {
    List<int> imageBytes = await image.readAsBytes();
    return imageBytes;
  }
  sendRequest() async {
    String base64Image = await _imageToBase64(this.image);
    List<int> imageBytes = await _imageToBytes(this.image);

    print(base64Image);

    UriData image = new UriData.fromString(base64Image, mimeType: "image/jpeg", base64: true);
    Map prepareJson = {
      'gluckometerImage': image.toString(),
      'language': 'cs',
    };
    String jsonR = jsonEncode(prepareJson);

    http.Response response = await http.post("https://smart-health-hackathon-server.herokuapp.com/detect",
        headers: {"Content-Type": "application/json"},
        body: jsonR
    );
      print("Sending:");
      print(jsonR);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.body);
      print(response.headers);
      print(response.request);
      return response.body;
  }
}

class DetectResponse {
  double glucoseValue;
  String text;
  String mp3Base64;
  File mp3;

  DetectResponse({this.glucoseValue, this.text, this.mp3Base64, this.mp3});

  factory DetectResponse.fromJson(Map<String, dynamic> jsonR) {
    //Uint8List bytes = base64.decode(jsonR['data']['speech']["mp3"]);

    return DetectResponse(
      glucoseValue: jsonR['data']['glucoseValue'] as double,
      text: jsonR['data']['speech']['text'] as String,
      mp3Base64: jsonR['data']['speech']['mp3'],
    );
  }

  processSound() async {
    String rawMP3 = this.mp3Base64;
    String mp3Base64 = this.mp3Base64.split(",")[1];
    print(mp3Base64);
    Uint8List bytes = base64.decode(mp3Base64);
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    File file = File(
        "$tempPath/" + DateTime.now().millisecondsSinceEpoch.toString() + ".mp3");
    print("File...");
    print(file.path);
    await file.writeAsBytes(bytes, flush: true);
    this.mp3 = file;
  }

  String getText() {
    return this.text;
  }

  String getValue() {
    return this.glucoseValue.toString();
  }

  File getSound() {
    return this.mp3;
  }
}