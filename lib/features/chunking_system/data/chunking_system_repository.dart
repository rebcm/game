import 'package:passdriver/features/chunking_system/domain/chunking_system_repository_interface.dart';

class ChunkingSystemRepository implements IChunkingSystemRepository {
  @override
  Future<List<Chunk>> getChunksAroundLocation(LatLng location, double radius) async {
    // implement logic to fetch chunks from the backend or local storage
  }

  @override
  Future<void> updateChunk(Chunk chunk) async {
    // implement logic to update a chunk
  }
}
