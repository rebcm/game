class Chunk {
  final int width;
  final int height;
  final int depth;
  final List<int> blocks;

  Chunk({required this.width, required this.height, required this.depth, required this.blocks});

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
      'blocks': blocks,
    };
  }
}
