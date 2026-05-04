import 'package:test/test.dart';
import 'package:game/services/chunk_service.dart';
import 'package:game/models/chunk_model.dart';
import 'package:game/errors/chunk_not_found_error.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('ChunkService', () {
    test('getChunk returns ChunkModel on 200', () async {
      final httpClient = MockClient((request) async {
        return http.Response('{"data": "chunk_data"}', 200);
      });
      final service = ChunkService();
      http.Client client = httpClient;
      // ignore: unnecessary_cast
      service._httpClient = client as http.Client;

      final chunk = await service.getChunk(0, 0);

      expect(chunk, isA<ChunkModel>());
      expect(chunk.data, 'chunk_data');
    });

    test('getChunk throws ChunkNotFoundError on 404', () async {
      final httpClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      final service = ChunkService();
      http.Client client = httpClient;
      // ignore: unnecessary_cast
      service._httpClient = client as http.Client;

      expect(() async => await service.getChunk(0, 0), throwsA(isA<ChunkNotFoundError>()));
    });

    test('fetchChunk returns ChunkModel on success', () async {
      final httpClient = MockClient((request) async {
        return http.Response('{"data": "chunk_data"}', 200);
      });
      final service = ChunkService();
      http.Client client = httpClient;
      // ignore: unnecessary_cast
      service._httpClient = client as http.Client;

      final chunk = await service.fetchChunk(0, 0);

      expect(chunk, isA<ChunkModel>());
      expect(chunk.data, 'chunk_data');
    });

    test('fetchChunk returns empty ChunkModel on 404', () async {
      final httpClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      final service = ChunkService();
      http.Client client = httpClient;
      // ignore: unnecessary_cast
      service._httpClient = client as http.Client;

      final chunk = await service.fetchChunk(0, 0);

      expect(chunk, isA<ChunkModel>());
      expect(chunk.data, '');
    });
  });
}
