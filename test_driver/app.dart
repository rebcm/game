import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: app.MyApp(),
        floatingActionButton: FloatingActionButton(
          key: Key('stress_test_button'),
          onPressed: () {
            // implement stress test logic here
          },
          tooltip: 'Stress Test',
          child: Icon(Icons.play_arrow),
        ),
      ),
    ),
  );
}
