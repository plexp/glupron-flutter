// WelcomeScreen.dart

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                child: Text(""),
              ),
            ]
          ),
        ),
    );

  }
}
