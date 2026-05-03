import 'package:flutter/material.dart';
import 'package:game/chunk/chunk_manager.dart';

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
  final ChunkManager _chunkManager = ChunkManager(capacity: 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chunk Manager Example'),
      ),
    );
  }
}
