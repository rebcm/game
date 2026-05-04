class ChunkNotFoundError implements Exception {
  final String message;

  ChunkNotFoundError(this.message);

  factory ChunkNotFoundError.fromJson(Map<String, dynamic> json) {
    return ChunkNotFoundError(json['message']);
  }
}
