import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager.dart';

void main() {
  test('ChunkManager loads chunks around player', () {
    ChunkManager chunkManager = ChunkManager();
    chunkManager.loadChunks(0, 0);
    // Add expectations based on the print statements or implement a better testing strategy
  });
}
