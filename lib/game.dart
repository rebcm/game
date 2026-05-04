import 'package:flutter/material.dart';
import 'package:game/chunk/chunk_manager.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final ChunkManager _chunkManager = ChunkManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Game'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _chunkManager.updateChunkColliders();
  }
}
