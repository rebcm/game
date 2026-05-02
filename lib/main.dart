import 'package:flutter/material.dart';
import 'package:rebcm/optimization/memory_optimizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _list = [];

  void _optimizeMemory() {
    MemoryOptimizer.optimizeList(_list);
    MemoryOptimizer.optimizeLoop(_list, (element) {
      // Process element
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebcm Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _optimizeMemory,
          child: Text('Optimize Memory'),
        ),
      ),
    );
  }
}
