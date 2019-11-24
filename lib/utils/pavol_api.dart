import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert' show utf8;
import 'dart:typed_data';

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

    http.post("https://smart-health-hackathon-server.herokuapp.com/detect",
        headers: {"Content-Type": "application/json"},
        body: jsonR
    ).then((http.Response response) {
      print("Sending:");
      print(jsonR);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.body);
      print(response.headers);
      print(response.request);
      this.body = response.body;
      print(this.body);
    });
  }
}

class DetectResponse {
  double glucoseValue;
  String text;
  String mp3Base64;
  File mp3;

  DetectResponse({this.glucoseValue, this.text, this.mp3Base64, this.mp3});

  factory DetectResponse.fromJon(Map json) {
    Uint8List bytes = base64.decode(json['data']["mp3"]);

    return DetectResponse(
      glucoseValue: json['glucoseValue'] as double,
      text: json['data']['text'] as String,
      mp3Base64: json['data']['mp3'],

    );
  }

}