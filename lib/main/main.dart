import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/utils/state_size_analyzer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Your providers here
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s World'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => StateSizeAnalyzer.analyze(context),
          child: Text('Analyze State Size'),
        ),
      ),
    );
  }
}
