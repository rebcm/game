import 'package:flutter/material.dart';
import 'package:game/main.dart' as game;

void main() {
  runApp(
    MaterialApp(
      home: MemoryBaselineTest(),
    ),
  );
}

class MemoryBaselineTest extends StatefulWidget {
  @override
  _MemoryBaselineTestState createState() => _MemoryBaselineTestState();
}

class _MemoryBaselineTestState extends State<MemoryBaselineTest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await game.main();
      // Implement memory measurement logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Memory Baseline Test'),
      ),
    );
  }
}
