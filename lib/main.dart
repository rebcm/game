import 'package:flutter/material.dart';
import 'package:game/chunking_system/chunk_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ChunkManager _chunkManager = ChunkManager(chunkSize: 16, renderDistance: 5);
  int _playerX = 0;
  int _playerZ = 0;

  void _updatePlayerPosition(int x, int z) {
    setState(() {
      _playerX = x;
      _playerZ = z;
      _chunkManager.updateChunks(_playerX, _playerZ);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chunks: ${_chunkManager.chunks.length}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _updatePlayerPosition(_playerX + 16, _playerZ),
        child: Icon(Icons.add),
      ),
    );
  }
}
