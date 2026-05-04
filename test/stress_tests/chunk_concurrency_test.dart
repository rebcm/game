import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager.dart';
import 'dart:async';

void main() {
  group('Chunk Concurrency Test', () {
    test('Multiple simultaneous writes to the same chunk', () async {
      final chunkManager = ChunkManager();
      final chunkKey = 'test_chunk';

      await chunkManager.initializeChunk(chunkKey);

      const numberOfWrites = 10;
      final futures = <Future>[];

      for (var i = 0; i < numberOfWrites; i++) {
        futures.add(chunkManager.writeChunk(chunkKey, 'data_$i'));
      }

      await Future.wait(futures);

      final chunkData = await chunkManager.readChunk(chunkKey);
      expect(chunkData, isNotNull);
    });

    test('Multiple simultaneous writes to different chunks', () async {
      final chunkManager = ChunkManager();
      final chunkKeys = List<String>.generate(10, (index) => 'chunk_$index');

      await Future.wait(chunkKeys.map((key) => chunkManager.initializeChunk(key)));

      final futures = <Future>[];

      for (var i = 0; i < chunkKeys.length; i++) {
        futures.add(chunkManager.writeChunk(chunkKeys[i], 'data_$i'));
      }

      await Future.wait(futures);

      for (var i = 0; i < chunkKeys.length; i++) {
        final chunkData = await chunkManager.readChunk(chunkKeys[i]);
        expect(chunkData, 'data_$i');
      }
    });
  });
}
