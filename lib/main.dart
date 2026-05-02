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
      title: 'Animation Demo',
      home: Screen1(),
      routes: {
        '/screen2': (context) => Screen2(),
      },
    );
  }
}
