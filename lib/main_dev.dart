import 'package:flutter/material.dart';
import 'package:passdriver/features/api_test/api_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      home: ApiTestFeature(),
    );
  }
}
