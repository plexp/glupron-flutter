import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert' show utf8;

import 'package:http/http.dart' as http;


class DetectSend {
  File image;

  DetectSend({this.image});

  Future<String> _imageToBase64(image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  sendRequest() async {
    String base64Image = await _imageToBase64(this.image);

    Map prepareJson = {
      'gluckometerImage': base64Image,

    };
    String jsonR = jsonEncode(prepareJson);

    http.post("https://smart-health-hackathon-server.herokuapp.com/detect",
        headers: {"Content-Type": "application/json"},
        body: jsonR
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.body);
      print(response.headers);
      print(response.request);
    });
  }

}