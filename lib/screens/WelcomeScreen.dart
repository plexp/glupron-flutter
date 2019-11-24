// WelcomeScreen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  List<String> _texts;

  Future<String> getLanguage() async {
    var preferences = await SharedPreferences.getInstance();

    return preferences.getString('language');
  }

  void switchLanguage() async{
    String language = await getLanguage();
    print(language);
    List<String> text;
    
    print(language);
    
    switch(language) {
      case 'CZ': {
        text = ['Vyfotit', 'Statistiky', 'Nastavení'];
        break;
      }
      case 'EN': {
        text = ['Take photo', 'Statistic', 'Settings'];
        break;
      }
      default: {
        text = ['Vyfotit', 'Statistiky', 'Nastavení'];
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
                        child: _texts[0] == null
                            ? Center(child: CircularProgressIndicator())
                            : Text(_texts[0],
                            style: TextStyle(fontSize: 70, color: Colors.black,), textAlign: TextAlign.center,
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
                        child: _texts[1] == null
                            ? Center(child: CircularProgressIndicator())
                            : Text(_texts[1],
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
                          child: _texts[2] == null
                              ? Center(child: CircularProgressIndicator())
                              : Text(_texts[2],
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