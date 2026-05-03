class Chunk {
  final int x;
  final int y;
  final int z;
  final Map<String, int> _blocks = {};

  Chunk(this.x, this.y, this.z);

  void setBlock(int x, int y, int z, int blockType) {
    _blocks['$x,$y,$z'] = blockType;
  }

  int getBlock(int x, int y, int z) {
    return _blocks['$x,$y,$z'] ?? 0;
  }
}
