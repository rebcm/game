import 'package:flutter/material.dart';
import 'package:rebcm/models/chunk.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() async {
  runApp(MyApp());
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ChunkService _chunkService = ChunkService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final chunk = Chunk(x: 0, y: 0, z: 0);
            final mesh = await _chunkService.generateMesh(chunk);
            print(mesh);
          },
          child: Text('Generate Mesh'),
        ),
      ),
    );
  }
}
