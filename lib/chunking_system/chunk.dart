class Chunk {
  final int x;
  final int z;
  bool isLoaded = false;

  Chunk({required this.x, required this.z});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chunk && runtimeType == other.runtimeType && x == other.x && z == other.z;

  @override
  int get hashCode => x.hashCode ^ z.hashCode;
}
