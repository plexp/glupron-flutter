// WelcomeScreen.dart

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Title',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Title'),
          ),
          body: Center(
            child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(30.0),
                        onPressed: () {
                          Navigator.pushNamed(context, '/foto');
                        },
                        child: const Text('Vyfotit',
                            style: TextStyle(fontSize: 70)
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                    flex:4,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(20.0),
                        onPressed: () {
                          Navigator.pushNamed(context, '/statistic');
                        },
                        child: const Text('Statistiky',
                            style: TextStyle(fontSize: 50)
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                      flex:4,
                      child: Container(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(20.0),
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: const Text('Nastavení',
                              style: TextStyle(fontSize: 50)
                          ),
                        ),
                      )
                  )
                ],
            )
          ),
        )
    );
  }
}