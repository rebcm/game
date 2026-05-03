import 'package:flutter/material.dart';
import 'package:game/chunk_generation/chunk_generator.dart';
import 'package:game/utils/isolate_guard/isolate_guard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    IsolateGuard.killAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chunk Generation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ChunkGenerator.generateChunk(0, 0);
          },
          child: Text('Generate Chunk'),
        ),
      ),
    );
  }
}
