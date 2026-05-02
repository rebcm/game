import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/upload_chunk.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('UploadChunk', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('should handle interrupted uploads', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Connection closed before full header was received'));
      expect(() async => await UploadChunk(client: client).uploadChunk(chunk: 'test_chunk', chunkId: 'test_id'), throwsA(isA<http.ClientException>()));
    });

    test('should handle corrupted files', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Invalid chunk data'));
      expect(() async => await UploadChunk(client: client).uploadChunk(chunk: 'corrupted_chunk', chunkId: 'test_id'), throwsA(isA<http.ClientException>()));
    });

    test('should handle chunk size limits', () async {
      when(() => client.post(any())).thenThrow(http.ClientException('Chunk size exceeds maximum allowed size'));
      expect(() async => await UploadChunk(client: client).uploadChunk(chunk: 'large_chunk' * 1000000, chunkId: 'test_id'), throwsA(isA<http.ClientException>()));
    });
  });
}
