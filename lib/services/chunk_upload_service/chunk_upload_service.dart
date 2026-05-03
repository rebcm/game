import 'package:http/http.dart' as http;
import 'package:rebcm/data/d1_repository.dart';
import 'package:rebcm/data/r2_repository.dart';

class ChunkUploadService {
  final D1Repository _d1Repository;
  final R2Repository _r2Repository;

  ChunkUploadService(this._d1Repository, this._r2Repository);

  Future<void> uploadChunk(String chunkId, List<int> chunkData) async {
    try {
      await _r2Repository.uploadChunk(chunkId, chunkData);
    } catch (e) {
      await _d1Repository.deleteChunkRecord(chunkId);
      rethrow;
    }
  }
}
