import 'package:flutter/material.dart';
import 'package:rebcm/screens/screen1.dart';
import 'package:rebcm/screens/screen2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen1(),
      routes: {
        '/screen1': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
      },
    );
  }
}
