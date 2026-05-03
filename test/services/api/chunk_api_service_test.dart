import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/api/chunk_api_service.dart';
import 'package:rebcm/models/chunk_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ChunkApiService', () {
    late ChunkApiService service;
    late MockHttpClient client;

    setUp(() {
      client = MockHttpClient();
      service = ChunkApiService(client);
    });

    test('getChunk returns chunk when response is 200', () async {
      final worldId = 'world123';
      final x = 1;
      final z = 2;
      final chunk = ChunkModel(x: x, z: z, data: []);

      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response(jsonEncode(chunk.toJson()), 200));

      final result = await service.getChunk(worldId, x, z);

      expect(result, chunk);
    });

    test('saveChunk returns true when response is 200', () async {
      final worldId = 'world123';
      final x = 1;
      final z = 2;
      final chunk = ChunkModel(x: x, z: z, data: []);

      when(() => client.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 200));

      final result = await service.saveChunk(worldId, x, z, chunk);

      expect(result, true);
    });
  });
}
