import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/storage/storage_manager.dart';
import 'package:rebcm/services/storage/chunk_uploader.dart';
import 'package:rebcm/models/chunk_model.dart';

class MockChunkUploader extends Mock implements ChunkUploader {}

void main() {
  group('StorageManager', () {
    late StorageManager storageManager;
    late MockChunkUploader chunkUploader;

    setUp(() {
      chunkUploader = MockChunkUploader();
      storageManager = StorageManager(chunkUploader);
    });

    test('saveChunk deletes from D1 if upload to R2 fails', () async {
      // Arrange
      final chunk = ChunkModel(id: '1', data: 'data');
      when(() => chunkUploader.uploadChunk(chunk)).thenAnswer((_) async => false);

      // Act and Assert
      await expectLater(storageManager.saveChunk(chunk), completes);
      verify(() => deleteFromD1(chunk.id)).called(1);
    });
  });
}
