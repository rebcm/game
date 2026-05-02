import 'package:flutter/material.dart';
import 'package:rebcm/utils/repaint_rainbow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: GamePage(),
    );
  }
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintRainbow(
        child: // Your game widget here,
      ),
    );
  }
}
