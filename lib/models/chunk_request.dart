class ChunkRequest {
  final int x;
  final int y;
  final int z;

  ChunkRequest({required this.x, required this.y, required this.z});

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }
}
