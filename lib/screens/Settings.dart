// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> _texts;

  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  setLanguage(language) async{
    await getInstance().then((value) {
      value.setString('language', language);
    });
    switchLanguage();
  }

  Future<String> getLanguage() async {
    var preferences = await SharedPreferences.getInstance();

    return preferences.getString('language');
  }

  void switchLanguage() async{
    String language = await getLanguage();
    List<String> text;
    switch(language) {
      case 'CZ': {
        text = ['Nastavení', 'EN', 'Přepnout na angličtinu', 'Zpět do menu'];
        break;
      }
      case 'EN': {
        text = ['Settings', 'CZ', 'Switch to czech', 'Back to menu'];
        break;
      }
      default: {
        text= ['Nastavení', 'EN', 'Přepnout na angličtinu', 'Zpět do menu'];
      }
    }
    setState(() {
      _texts = text;
    });
  }

  @override
  void initState() {
    super.initState();
    switchLanguage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:_texts[0] == null
            ? Center(child: CircularProgressIndicator())
            : Text(_texts[0]),
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
                      if(_texts[1] != null){
                        setLanguage(_texts[1]);
                      }
                    },
                    child: _texts[2] == null
                        ? Center(child: CircularProgressIndicator())
                        : Text(_texts[2],
                      style: TextStyle(fontSize: 40, color: Colors.black), textAlign: TextAlign.center,
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: _texts[3] == null
                        ? Center(child: CircularProgressIndicator())
                        : Text(_texts[3],
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
