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

  setLanguage(language) async{
    await getInstance().then((value) {
      value.setString('language', language);
    });
  }

  Future<String> getLanguage() async {
    var preferences = await SharedPreferences.getInstance();

    return preferences.getString('language');
  }

  List<String> switchLanguage() {
    String language;
    getLanguage().then((value) {
      language = value;
    });

    switch(language) {
      case 'CZ': {
        return ['Přihlásit se', 'EN', 'Přepnout na angličtinu'];
      }
      case 'EN': {
        return ['Login', 'CZ', 'Switch to czech'];
      }
      default: {
        return ['Přihlásit se', 'EN', 'Přepnout na angličtinu'];
      }
    }
  }

  Widget build(BuildContext context) {
    List<String> texts = switchLanguage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistika'),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color.fromRGBO(245, 230, 228, 1),
                    padding: const EdgeInsets.all(30.0),
                    onPressed: () {
                    },
                    child: Text(texts[0],
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                ),
              ),
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
                    onPressed: () => setLanguage('EN'),
                    //onPressed: () {},
                    child: Text(texts[2],
                      style: TextStyle(fontSize: 40),textAlign: TextAlign.center,
                  ),
                ),
              ),
              ),
            ]
        ),
      ),
    );

  }
}
