import 'package:rebcm/models/chunk_model.dart';
import 'package:rebcm/services/storage/chunk_uploader.dart';

class StorageManager {
  final ChunkUploader _chunkUploader;

  StorageManager(this._chunkUploader);

  Future<void> saveChunk(ChunkModel chunk) async {
    try {
      // Save chunk to D1
      await saveToD1(chunk);

      // Upload chunk to R2
      final uploadSuccess = await _chunkUploader.uploadChunk(chunk);

      if (!uploadSuccess) {
        // Rollback: delete chunk from D1 if R2 upload fails
        await deleteFromD1(chunk.id);
      }
    } catch (e) {
      // Rollback: delete chunk from D1 if any error occurs
      await deleteFromD1(chunk.id);
      rethrow;
    }
  }

  Future<void> saveToD1(ChunkModel chunk) async {
    // Implement saving to D1
  }

  Future<void> deleteFromD1(String chunkId) async {
    // Implement deleting from D1
  }
}
