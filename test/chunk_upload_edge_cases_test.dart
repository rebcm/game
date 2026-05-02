import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_upload_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Chunk Upload Edge Cases', () {
    late http.Client client;
    late ChunkUploadService service;

    setUp(() {
      client = MockHttpClient();
      service = ChunkUploadService(client);
    });

    test('should handle interrupted uploads', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Connection closed before full header was received'));
      expect(() async => service.uploadChunk('test_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should handle corrupted files', () async {
      when(() => client.post(any())).thenAnswer((_) async => http.Response('Invalid checksum', 400));
      expect(() async => service.uploadChunk('corrupted_chunk'), throwsA(isA<http.ClientException>()));
    });

    test('should handle chunk size limits', () async {
      when(() => client.post(any())).thenAnswer((_) async => http.Response('Chunk size exceeds limit', 413));
      expect(() async => service.uploadChunk('large_chunk'), throwsA(isA<http.ClientException>()));
    });
  });
}
