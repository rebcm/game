import 'package:flutter/material.dart';
import 'package:passdriver/features/r2/chunk_naming.dart';

class R2ChunkService with ChangeNotifier {
  String? _currentVersion;

  String? get currentVersion => _currentVersion;

  Future<void> loadChunk(String chunkName) async {
    final version = _currentVersion;
    if (version == null) {
      // handle no version case
      return;
    }
    final key = R2ChunkConfig.getChunkKey(version, chunkName);
    // implement logic to load chunk from R2 using the key
  }
}
