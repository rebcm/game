import 'package:rebcm/models/chunk.dart';

class TerrainGenerator {
  static Chunk generateChunk(int x, int z) {
    // Implement your chunk generation logic here
    // For demonstration purposes, a simple chunk is returned
    return Chunk(x, z, List.generate(16 * 16 * 256, (index) => 1));
  }
}
