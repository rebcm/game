import 'package:flutter/material.dart';
import 'package:rebcm/telas/blocos_tela.dart';

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
      home: BlocosTela(),
    );
  }
}
