import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk/chunk_manager.dart';

void main() {
  late ChunkManager chunkManager;

  setUp(() {
    chunkManager = ChunkManager();
  });

  test('Chunk dimension is retrieved correctly', () {
    expect(chunkManager.getChunkDimension(), 16);
  });

  test('Neighbor chunk count is retrieved correctly', () {
    expect(chunkManager.getNeighborChunkCount(), 1);
  });
}
