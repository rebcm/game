import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/storage/chunk_uploader.dart';
import 'package:rebcm/models/chunk_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ChunkUploader', () {
    late ChunkUploader uploader;
    late MockHttpClient httpClient;

    setUp(() {
      httpClient = MockHttpClient();
      uploader = ChunkUploader(httpClient);
    });

    test('uploadChunk returns true on successful upload', () async {
      // Arrange
      final chunk = ChunkModel(id: '1', data: 'data');
      when(() => httpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 201));

      // Act
      final result = await uploader.uploadChunk(chunk);

      // Assert
      expect(result, true);
    });

    test('uploadChunk returns false on failed upload', () async {
      // Arrange
      final chunk = ChunkModel(id: '1', data: 'data');
      when(() => httpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 500));

      // Act
      final result = await uploader.uploadChunk(chunk);

      // Assert
      expect(result, false);
    });
  });
}
