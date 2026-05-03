import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/storage/chunk_uploader.dart';
import 'package:rebcm/services/storage/d1_storage.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockD1Storage extends Mock implements D1Storage {}

void main() {
  late ChunkUploader _chunkUploader;
  late MockD1Storage _mockD1Storage;
  late MockHttpClient _mockHttpClient;

  setUp(() {
    _mockHttpClient = MockHttpClient();
    _mockD1Storage = MockD1Storage();
    _chunkUploader = ChunkUploader(_mockD1Storage, _mockHttpClient);
  });

  group('ChunkUploader', () {
    test('uploadChunk success', () async {
      final chunkId = 'testChunkId';
      final chunkData = [1, 2, 3];

      when(() => _mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 200));
      when(() => _mockD1Storage.deleteChunkRecord(chunkId)).thenAnswer((_) async => Future.value());

      await _chunkUploader.uploadChunk(chunkId, chunkData);

      verify(() => _mockD1Storage.deleteChunkRecord(chunkId)).called(1);
    });

    test('uploadChunk failure', () async {
      final chunkId = 'testChunkId';
      final chunkData = [1, 2, 3];

      when(() => _mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 500));
      when(() => _mockD1Storage.deleteChunkRecord(chunkId)).thenAnswer((_) async => Future.value());

      expect(() async => await _chunkUploader.uploadChunk(chunkId, chunkData), throwsException);
      verify(() => _mockD1Storage.deleteChunkRecord(chunkId)).called(1);
    });
  });
}
