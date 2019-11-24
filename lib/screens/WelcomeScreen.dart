// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {

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
        return ['Vyfotit', 'Statistiky', 'Nastavení'];
      }
      case 'EN': {
        return ['Take photo', 'Statistic', 'Settings'];
      }
      default: {
        return ['Vyfotit', 'Statistiky', 'Nastavení'];
      }
    }
  }

  Widget build(BuildContext context) {
    List<String> texts = switchLanguage();
    return Scaffold(
          appBar: AppBar(
            //backgroundColor: Color.fromRGBO(232, 60, 63, 1),
            title: Text('Menu'),
          ),
          body: Center(
            child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          padding: EdgeInsets.all(30.0),
                          onPressed: () {
                          Navigator.pushNamed(context, '/foto');
                        },
                        child: Text(texts[0],
                            style: TextStyle(fontSize: 70, color: Colors.black),
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                    flex:5,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color.fromRGBO(245, 230, 228, 1),
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          Navigator.pushNamed(context, '/statistic');
                        },
                        child: Text(texts[1],
                            style: TextStyle(fontSize: 50, color: Colors.black)
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                      flex:5,
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Color.fromRGBO(245, 230, 228, 1),
                          padding: EdgeInsets.all(20.0),
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: Text(texts[2],
                              style: TextStyle(fontSize: 50, color: Colors.black)
                          ),
                        ),
                      )
                  )
                ],
            )
          ),
    );
  }
}