import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/chunk_system/data/chunk_repository.dart';

class ChunkManager with ChangeNotifier {
  final ChunkRepository _repository;

  ChunkManager(this._repository);

  void loadChunks(LatLngBounds bounds, int zoom) {
    // calculate chunks to load based on bounds and zoom
    // call _repository.loadChunk for each chunk
    notifyListeners();
  }

  void unloadChunks(LatLngBounds bounds, int zoom) {
    // calculate chunks to unload based on bounds and zoom
    // call _repository.unloadChunk for each chunk
    notifyListeners();
  }
}
