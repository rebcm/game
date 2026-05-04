class Chunk {
  final List<int> data;

  Chunk({required this.data});

  factory Chunk.empty() => Chunk(data: []);
}

class ChunkManager {
  static const int MAX_CHUNK_SIZE = 1024 * 1024; // 1MB

  static void processChunk(Chunk chunk) {
    if (chunk.data.isEmpty) {
      throw ArgumentError('Chunk cannot be empty');
    }
    if (chunk.data.length > MAX_CHUNK_SIZE) {
      throw RangeError('Chunk exceeds maximum allowed size');
    }
    // Process the chunk data
  }
}
