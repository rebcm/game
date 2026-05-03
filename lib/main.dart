import 'package:flutter/material.dart';
import 'package:rebcm/widgets/dicas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Dicas(),
      ),
    );
  }
}
