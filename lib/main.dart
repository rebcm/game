import 'package:flutter/material.dart';
import 'package:rebcm/services/chunk_service.dart';
import 'package:rebcm/models/chunk.dart';

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
  ChunkService _chunkService;

  @override
  void initState() {
    super.initState();
    List<Chunk> chunks = [Chunk([1, 2, 3]), Chunk([4, 5, 6])];
    _chunkService = ChunkService(chunks);
    _chunkService.optimizeChunks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Optimized Chunks'),
      ),
    );
  }
}
