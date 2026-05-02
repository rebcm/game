import 'package:http/http.dart' as http;
import 'package:rebcm/repositories/chunk_repository.dart';

class ChunkService {
  final ChunkRepository _repository;

  ChunkService(this._repository);

  Future<Chunk> getChunk(String worldId, int x, int z) => _repository.getChunk(worldId, x, z);
  Future<void> saveChunk(String worldId, int x, int z, Chunk chunk) => _repository.saveChunk(worldId, x, z, chunk);
}
