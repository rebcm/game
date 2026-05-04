import 'package:flutter/material.dart';
import 'package:game/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            'Detailed description of the game',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
