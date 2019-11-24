// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  RaisedButton switchLanguage() {
    SharedPreferences prefs;
    getInstance().then((value) {
      prefs = value;
    });
    String language = prefs.getString('language');

    switch(language){
      case 'CZ': {
        return RaisedButton(
          color: Color.fromRGBO(245, 230, 228, 1),
          padding: const EdgeInsets.all(30.0),
          onPressed: () {
            prefs.setString('language', 'EN');
          },
          child: const Text('Přepnout na angličtinu',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        );}
      case 'EN':{
        return RaisedButton(
          color: Color.fromRGBO(245, 230, 228, 1),
          padding: const EdgeInsets.all(30.0),
          onPressed: () {
            prefs.setString('language', 'CZ');
          },
          child: const Text('Switch to czech',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        );}
      default: {
        prefs.setString('language', 'CZ');
        return RaisedButton(
          color: Color.fromRGBO(245, 230, 228, 1),
          padding: const EdgeInsets.all(30.0),
          onPressed: () {
            prefs.setString('language', 'EN');
          },
          child: const Text('Přepnout na angličtinu',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Statistika'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(""),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color.fromRGBO(245, 230, 228, 1),
                    padding: const EdgeInsets.all(30.0),
                    onPressed: () {
                    },
                    child: const Text('Přihlásit se',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  child: switchLanguage(),
                ),
              ),
            ]
          ),
        ),
    );

  }
}
