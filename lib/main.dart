import "package:game/config/env_config.dart";
import 'package:flutter/material.dart';
import 'package:game/chunk_manager/chunk_collision_manager.dart';

void main() {
  EnvConfig.loadEnv();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(),
    );
  }
}

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  final ChunkCollisionManager _collisionManager = ChunkCollisionManager();

  @override
  Widget build(BuildContext context) {
    // Implement game widget build logic
    return Container();
  }

  void _updateLoadedChunks(List<Chunk> chunks) {
    _collisionManager.updateLoadedChunks(chunks);
    _collisionManager.validateColliders();
  }
}
