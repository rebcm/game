import 'package:flutter/material.dart';

class ChunkManager with ChangeNotifier {
  List<Chunk> _chunks = [];
  List<Chunk> get chunks => _chunks;

  void loadChunk(Chunk chunk) {
    if (!_chunks.contains(chunk)) {
      _chunks.add(chunk);
      notifyListeners();
    }
  }

  void unloadChunk(Chunk chunk) {
    if (_chunks.contains(chunk)) {
      _chunks.remove(chunk);
      notifyListeners();
    }
  }

  void updateChunkColliders() {
    for (var chunk in _chunks) {
      chunk.updateColliders();
    }
  }
}

class Chunk {
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  void load() {
    _isLoaded = true;
  }

  void unload() {
    _isLoaded = false;
  }

  void updateColliders() {
  }
}
