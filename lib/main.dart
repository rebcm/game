import 'package:flutter/material.dart';
import 'audio.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    RebecaSkin(),
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioScreen(),
    );
  }
}
