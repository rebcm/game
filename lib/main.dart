// Example main file, ensure it doesn't cause any linting errors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Rebeca\'s Game'),
        ),
      ),
    );
  }
}
