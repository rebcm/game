class ChunkNotFoundError implements Exception {
  final String message;

  ChunkNotFoundError(this.message);

  factory ChunkNotFoundError.fromCode(int code) {
    return ChunkNotFoundError('Chunk not found with code $code');
  }
}
