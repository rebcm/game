import 'package:flutter/material.dart';
import 'package:game/services/chunk_cache/chunk_cache_service.dart';

class ChunkCacheProvider with ChangeNotifier {
  late ChunkCacheService _chunkCacheService;

  ChunkCacheService get chunkCacheService => _chunkCacheService;

  ChunkCacheProvider() {
    _chunkCacheService = ChunkCacheService();
  }

  void updateChunkCacheService(ChunkCacheService chunkCacheService) {
    _chunkCacheService = chunkCacheService;
    notifyListeners();
  }
}
