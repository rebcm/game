import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service.dart';
import 'package:game/models/chunk_model.dart';
import 'package:game/errors/chunk_not_found_error.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('ChunkService', () {
    test('returns ChunkModel when the response is 200', () async {
      final chunkService = ChunkService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{"data": "chunk_data"}', 200);
      });
      http.Client client = mockHttpClient;
      final result = await chunkService.getChunk('0,0');
      expect(result, isA<ChunkModel>());
    });

    test('throws ChunkNotFoundError when the response is 404', () async {
      final chunkService = ChunkService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{"message": "Chunk not found"}', 404);
      });
      http.Client client = mockHttpClient;
      expect(() async => await chunkService.getChunk('0,0'), throwsA(isA<ChunkNotFoundError>()));
    });

    test('throws Exception when the response is not 200 or 404', () async {
      final chunkService = ChunkService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{"message": "Internal Server Error"}', 500);
      });
      http.Client client = mockHttpClient;
      expect(() async => await chunkService.getChunk('0,0'), throwsException);
    });
  });
}
