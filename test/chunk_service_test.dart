import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:game/services/chunk/chunk_service.dart';
import 'package:http/testing.dart';

void main() {
  group('ChunkService', () {
    test('fetchChunk succeeds with valid response', () async {
      final httpClient = MockClient((request) async {
        return http.Response('{"data": "chunk data"}', 200);
      });
      final chunkService = ChunkService(httpClient);
      final chunk = await chunkService.fetchChunk('chunk1');
      expect(chunk, 'chunk data');
    });

    test('fetchChunk fails with rate limit exceeded', () async {
      final httpClient = MockClient((request) async {
        return http.Response('{"data": "chunk data"}', 200);
      });
      final chunkService = ChunkService(httpClient);
      await chunkService.fetchChunk('chunk1');
      expect(() async => await chunkService.fetchChunk('chunk1'), throwsException);
    });
  });
}
