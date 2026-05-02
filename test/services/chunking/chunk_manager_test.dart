import 'package:test/test.dart';
import 'package:rebcm/services/chunking/chunk_manager.dart';

void main() {
  group('ChunkManager', () {
    test('should update chunks based on player position', () {
      ChunkManager chunkManager = ChunkManager();
      chunkManager.updateChunks(0, 0);
      expect(chunkManager.getChunks().length, 49); // 7x7 chunks
    });
  });
}
