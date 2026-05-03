import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/chunk_service.dart';

void main() {
  final chunkService = ChunkService(http.Client());

  runApp(MyApp(chunkService));
}

class MyApp extends StatelessWidget {
  final ChunkService _chunkService;

  const MyApp(this._chunkService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _chunkService.fetchChunk(const ChunkRequest(x: 0, z: 0));
            },
            child: const Text('Fetch Chunk'),
          ),
        ),
      ),
    );
  }
}
