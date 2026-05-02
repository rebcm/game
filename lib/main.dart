import 'package:flutter/material.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
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
    // Use _chunkService.generateMesh(chunk) where necessary
    return Container();
  }
}
