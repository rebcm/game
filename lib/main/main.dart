import 'package:flutter/material.dart';
import 'package:rebcm/main/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: Game(),
    );
  }
}
