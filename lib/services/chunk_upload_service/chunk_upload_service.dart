import 'package:http/http.dart' as http;
import 'package:rebcm/models/chunk_model.dart';
import 'package:rebcm/repositories/d1_repository.dart';
import 'package:rebcm/repositories/r2_repository.dart';

class ChunkUploadService {
  final D1Repository _d1Repository;
  final R2Repository _r2Repository;

  ChunkUploadService(this._d1Repository, this._r2Repository);

  Future<void> uploadChunk(ChunkModel chunk) async {
    try {
      await _r2Repository.uploadChunk(chunk);
    } catch (e) {
      await _d1Repository.deleteChunkRecord(chunk.id);
      rethrow;
    }
  }
}
