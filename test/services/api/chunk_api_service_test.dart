import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/api/chunk_api_service.dart';
import 'package:rebcm/models/chunk_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ChunkApiService service;
  late MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
    service = ChunkApiService(client);
  });

  group('getChunk', () {
    test('returns chunk when response is 200', () async {
      final worldId = 'world1';
      final x = 0;
      final z = 0;
      final chunk = ChunkModel(x: x, z: z, data: []);

      when(() => client.get(Uri.parse('/api/worlds/$worldId/chunks/$x/$z')))
          .thenAnswer((_) async => http.Response(jsonEncode(chunk.toJson()), 200));

      final result = await service.getChunk(worldId, x, z);

      expect(result, chunk);
    });

    test('returns null when response is not 200', () async {
      final worldId = 'world1';
      final x = 0;
      final z = 0;

      when(() => client.get(Uri.parse('/api/worlds/$worldId/chunks/$x/$z')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await service.getChunk(worldId, x, z);

      expect(result, null);
    });
  });

  group('saveChunk', () {
    test('returns true when response is 200', () async {
      final worldId = 'world1';
      final x = 0;
      final z = 0;
      final chunk = ChunkModel(x: x, z: z, data: []);

      when(() => client.put(Uri.parse('/api/worlds/$worldId/chunks/$x/$z'),
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(chunk.toJson())))
          .thenAnswer((_) async => http.Response('', 200));

      final result = await service.saveChunk(worldId, x, z, chunk);

      expect(result, true);
    });

    test('returns false when response is not 200', () async {
      final worldId = 'world1';
      final x = 0;
      final z = 0;
      final chunk = ChunkModel(x: x, z: z, data: []);

      when(() => client.put(Uri.parse('/api/worlds/$worldId/chunks/$x/$z'),
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(chunk.toJson())))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      final result = await service.saveChunk(worldId, x, z, chunk);

      expect(result, false);
    });
  });
}
