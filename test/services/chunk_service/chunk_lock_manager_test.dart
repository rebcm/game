import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service/chunk_lock_manager.dart';

void main() {
  group('ChunkLockManager', () {
    late ChunkLockManager lockManager;

    setUp(() {
      lockManager = ChunkLockManager();
    });

    test('should lock chunk writing', () async {
      final chunkId = 'testChunk';
      bool executed = false;

      await lockManager.withChunkLock(chunkId, () async {
        await Future.delayed(Duration(milliseconds: 100));
        executed = true;
      });

      expect(executed, true);
    });

    test('should not allow concurrent writing to the same chunk', () async {
      final chunkId = 'testChunk';
      bool firstExecutionStarted = false;
      bool secondExecutionStarted = false;
      bool firstExecutionFinished = false;

      final firstWrite = lockManager.withChunkLock(chunkId, () async {
        firstExecutionStarted = true;
        await Future.delayed(Duration(milliseconds: 100));
        firstExecutionFinished = true;
      });

      final secondWrite = lockManager.withChunkLock(chunkId, () async {
        secondExecutionStarted = true;
        await Future.delayed(Duration(milliseconds: 100));
        secondExecutionStarted = true;
      });

      await Future.wait([firstWrite, secondWrite]);

      expect(firstExecutionStarted, true);
      expect(secondExecutionStarted, true);
      expect(firstExecutionFinished, true);
      expect(firstExecutionStarted, lessThan(secondExecutionStarted));
    });
  });
}
