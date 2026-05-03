import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager/chunk_lock_manager.dart';

void main() {
  group('ChunkLockManager', () {
    late ChunkLockManager chunkLockManager;

    setUp(() {
      chunkLockManager = ChunkLockManager();
    });

    test('should process operations in order', () async {
      final operations = [];
      final chunkId = 'testChunk';

      chunkLockManager.enqueueOperation(chunkId, ChunkOperation(() async {
        operations.add(1);
      }));

      chunkLockManager.enqueueOperation(chunkId, ChunkOperation(() async {
        operations.add(2);
      }));

      await Future.delayed(Duration(milliseconds: 100));

      expect(operations, [1, 2]);
    });

    test('should not process operations concurrently for the same chunk', () async {
      final operations = [];
      final chunkId = 'testChunk';

      chunkLockManager.enqueueOperation(chunkId, ChunkOperation(() async {
        await Future.delayed(Duration(milliseconds: 50));
        operations.add(1);
      }));

      chunkLockManager.enqueueOperation(chunkId, ChunkOperation(() async {
        operations.add(2);
      }));

      await Future.delayed(Duration(milliseconds: 100));

      expect(operations, [1, 2]);
    });
  });
}
