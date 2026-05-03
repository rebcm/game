import 'package:game/services/chunk_service/chunk_lock_manager.dart';

class ChunkWriter {
  final ChunkLockManager _lockManager;

  ChunkWriter(this._lockManager);

  Future<void> writeChunk(String chunkId, dynamic data) async {
    await _lockManager.withChunkLock(chunkId, () async {
      // Implement actual chunk writing logic here
    });
  }
}
