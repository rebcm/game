import 'package:flutter/foundation.dart';

class ChunkRepository {
  final List<List<List<int>>> _chunks = [];

  List<List<List<int>>> getChunks() => _chunks;

  void loadChunk(int x, int y, int z) {
    // Implement loading logic here
    _chunks.add(List.generate(16, (_) => List.generate(16, (_) => List.generate(256, (_) => 0))));
  }

  void unloadChunk(int x, int y, int z) {
    // Implement unloading logic here
  }
}
