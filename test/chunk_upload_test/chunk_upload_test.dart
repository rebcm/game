import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/chunk_upload_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ChunkUploadService chunkUploadService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    chunkUploadService = ChunkUploadService(mockHttpClient);
  });

  group('ChunkUploadService', () {
    test('should throw error on interrupted upload', () async {
      when(() => mockHttpClient.post(any())).thenThrow(http.ClientException('Connection closed before full header was received'));

      expect(() async => await chunkUploadService.uploadChunk('test_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should throw error on corrupted file upload', () async {
      when(() => mockHttpClient.post(any())).thenThrow(http.ClientException('Invalid chunk data'));

      expect(() async => await chunkUploadService.uploadChunk('corrupted_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should throw error on chunk size limit exceeded', () async {
      when(() => mockHttpClient.post(any())).thenThrow(http.ClientException('Chunk size exceeds maximum allowed size'));

      expect(() async => await chunkUploadService.uploadChunk(List.generate(ChunkUploadService.maxChunkSize + 1, (index) => index)), throwsA(isA<http.ClientException>()));
    });
  });
}
