import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  app.main();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Creative Mode',
      home: app.GamePage(),
    );
  }
}
