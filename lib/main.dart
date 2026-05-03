import 'package:flutter/material.dart';
import 'package:rebcm/performance/fps_counter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FpsCounter()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fpsCounter = Provider.of<FpsCounter>(context);
    return Scaffold(
      body: Center(
        child: Text('FPS: ${fpsCounter.fps.toStringAsFixed(2)}'),
      ),
    );
  }
}
