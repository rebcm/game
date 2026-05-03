import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/models/chunk_model.dart';
import 'package:rebcm/repositories/d1_repository.dart';
import 'package:rebcm/repositories/r2_repository.dart';
import 'package:rebcm/services/chunk_upload_service/chunk_upload_service.dart';

class MockD1Repository extends Mock implements D1Repository {}

class MockR2Repository extends Mock implements R2Repository {}

void main() {
  late ChunkUploadService chunkUploadService;
  late MockD1Repository mockD1Repository;
  late MockR2Repository mockR2Repository;

  setUp(() {
    mockD1Repository = MockD1Repository();
    mockR2Repository = MockR2Repository();
    chunkUploadService = ChunkUploadService(mockD1Repository, mockR2Repository);
  });

  group('ChunkUploadService', () {
    test('should delete chunk record from D1 if R2 upload fails', () async {
      final chunk = ChunkModel(id: 'chunk-id', data: 'chunk-data');
      when(() => mockR2Repository.uploadChunk(chunk)).thenThrow(Exception('Upload failed'));

      expect(() async => chunkUploadService.uploadChunk(chunk), throwsException);
      verify(() => mockD1Repository.deleteChunkRecord(chunk.id)).called(1);
    });
  });
}
