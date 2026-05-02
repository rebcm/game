import 'package:flutter/material.dart';
import 'package:passdriver/features/chunk_system/data/chunk_repository.dart';

class ChunkProvider with ChangeNotifier {
  final ChunkRepository _repository = ChunkRepository();

  List<List<List<int>>> getChunks() => _repository.getChunks();

  void loadChunk(int x, int y, int z) {
    _repository.loadChunk(x, y, z);
    notifyListeners();
  }

  void unloadChunk(int x, int y, int z) {
    _repository.unloadChunk(x, y, z);
    notifyListeners();
  }
}
