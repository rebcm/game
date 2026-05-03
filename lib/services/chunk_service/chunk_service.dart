import 'package:flutter/material.dart';

class ChunkService with ChangeNotifier {
  int _chunkAtual = 0;

  int get chunkAtual => _chunkAtual;

  void mudarChunk() {
    _chunkAtual++;
    notifyListeners();
  }
}
