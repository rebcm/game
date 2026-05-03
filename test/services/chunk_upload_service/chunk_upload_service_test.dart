import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/data/d1_repository.dart';
import 'package:rebcm/data/r2_repository.dart';
import 'package:rebcm/services/chunk_upload_service/chunk_upload_service.dart';

class MockD1Repository extends Mock implements D1Repository {}

class MockR2Repository extends Mock implements R2Repository {}

void main() {
  late D1Repository d1Repository;
  late R2Repository r2Repository;
  late ChunkUploadService chunkUploadService;

  setUp(() {
    d1Repository = MockD1Repository();
    r2Repository = MockR2Repository();
    chunkUploadService = ChunkUploadService(d1Repository, r2Repository);
  });

  group('ChunkUploadService', () {
    test('uploadChunk succeeds when R2 upload is successful', () async {
      final chunkId = 'chunk1';
      final chunkData = [1, 2, 3];

      when(() => r2Repository.uploadChunk(chunkId, chunkData)).thenAnswer((_) async => Future.value());

      await chunkUploadService.uploadChunk(chunkId, chunkData);

      verify(() => r2Repository.uploadChunk(chunkId, chunkData)).called(1);
      verifyNever(() => d1Repository.deleteChunkRecord(chunkId));
    });

    test('uploadChunk fails and deletes D1 record when R2 upload fails', () async {
      final chunkId = 'chunk1';
      final chunkData = [1, 2, 3];

      when(() => r2Repository.uploadChunk(chunkId, chunkData)).thenThrow(Exception('R2 upload failed'));

      expect(() async => await chunkUploadService.uploadChunk(chunkId, chunkData), throwsException);

      verify(() => r2Repository.uploadChunk(chunkId, chunkData)).called(1);
      verify(() => d1Repository.deleteChunkRecord(chunkId)).called(1);
    });
  });
}
