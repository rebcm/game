import 'package:flutter/material.dart';
import 'package:rebcm/jogo/jogo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Building',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Jogo(),
    );
  }
}
