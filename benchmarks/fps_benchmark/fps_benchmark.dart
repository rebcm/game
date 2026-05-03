import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPS Benchmark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Ticker _ticker;
  int _fps = 0;
  int _frameCount = 0;
  late DateTime _lastTime;

  @override
  void initState() {
    super.initState();
    _lastTime = DateTime.now();
    _ticker = Ticker((elapsed) {
      _frameCount++;
      DateTime now = DateTime.now();
      if (now.difference(_lastTime).inSeconds >= 1) {
        setState(() {
          _fps = _frameCount;
          _frameCount = 0;
          _lastTime = now;
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FPS Benchmark'),
      ),
      body: Center(
        child: Text('FPS: $_fps'),
      ),
    );
  }
}
