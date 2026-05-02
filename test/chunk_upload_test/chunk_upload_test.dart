import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_upload_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Chunk Upload Tests', () {
    late http.Client client;
    late ChunkUploadService chunkUploadService;

    setUp(() {
      client = MockHttpClient();
      chunkUploadService = ChunkUploadService(client);
    });

    test('should handle interrupted uploads', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Connection closed before full header was received'));
      expect(() async => chunkUploadService.uploadChunk('test_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should handle corrupted files', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Invalid chunk data'));
      expect(() async => chunkUploadService.uploadChunk('corrupted_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should handle chunk size limits', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Chunk size exceeds maximum allowed size'));
      expect(() async => chunkUploadService.uploadChunk(List.filled(ChunkUploadService.maxChunkSize + 1, 0)), throwsA(isA<http.ClientException>()));
    });
  });
}
