import 'package:flutter/foundation.dart';

class ChunkCacheService with ChangeNotifier {
  final Map<String, dynamic> _activeChunks = {};
  final int _maxChunks;
  final int _unloadDistance;

  ChunkCacheService({int maxChunks = 100, int unloadDistance = 3})
      : _maxChunks = maxChunks,
        _unloadDistance = unloadDistance;

  void addChunk(String chunkKey, dynamic chunkData) {
    if (_activeChunks.containsKey(chunkKey)) return;

    if (_activeChunks.length >= _maxChunks) {
      _unloadDistantChunks();
    }

    _activeChunks[chunkKey] = chunkData;
    notifyListeners();
  }

  void removeChunk(String chunkKey) {
    _activeChunks.remove(chunkKey);
    notifyListeners();
  }

  void _unloadDistantChunks() {
    // Logic to determine and unload distant chunks based on _unloadDistance
    // For demonstration, we'll just remove the first chunk
    if (_activeChunks.isNotEmpty) {
      _activeChunks.remove(_activeChunks.keys.first);
    }
  }

  dynamic getChunk(String chunkKey) {
    return _activeChunks[chunkKey];
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
