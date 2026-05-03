import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  runApp(app.MyApp());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Concurrency Stress Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // play sound here
          },
          tooltip: 'Play Sound',
          child: Text('Play Sound'),
        ),
      ),
    );
  }
}
