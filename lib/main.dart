import 'package:flutter/material.dart';
import 'package:game/guia_construcao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuiaConstrucao(),
    );
  }
}
