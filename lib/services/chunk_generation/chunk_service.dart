import 'package:rebcm/services/chunk_generation/chunk_generator.dart';

class ChunkService {
  Future<Chunk> generateChunk(int x, int z) async {
    return await ChunkGenerator.generateChunk(x, z);
  }
}
