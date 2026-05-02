import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunking/chunk_storage_service.dart';
import 'package:rebcm/services/chunking/timestamp_chunk_versioning_strategy.dart';

void main() {
  group('ChunkStorageService', () {
    late ChunkStorageService service;

    setUp(() {
      service = ChunkStorageService(TimestampChunkVersioningStrategy());
    });

    test('save and load chunk', () async {
      final chunkId = 'testChunk';
      final chunkData = [1, 2, 3];
      await service.saveChunk(chunkId, chunkData);
      final loadedData = await service.loadChunk(chunkId);
      expect(loadedData, chunkData);
    });
  });
}
