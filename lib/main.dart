import 'package:flutter/material.dart';
import 'package:rebcm/screens/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Criativa',
      home: Menu(),
    );
  }
}
