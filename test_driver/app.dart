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
      home: Scaffold(
        body: Center(
          child: Text(
            'This is a very long text that should wrap correctly',
            key: Key('test_text'),
          ),
        ),
        appBar: AppBar(
          title: Text('Text Wrap Test'),
        ),
      ),
    );
  }
}
