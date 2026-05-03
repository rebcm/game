import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BenchmarkScene(),
    );
  }
}

class BenchmarkScene extends StatefulWidget {
  @override
  _BenchmarkSceneState createState() => _BenchmarkSceneState();
}

class _BenchmarkSceneState extends State<BenchmarkScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Flutter Scene Benchmark'),
      ),
    );
  }
}
