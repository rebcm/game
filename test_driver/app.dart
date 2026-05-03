import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  runApp(app.MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      home: app.GamePage(),
    );
  }
}
