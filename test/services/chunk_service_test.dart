import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:game/services/chunk_service.dart';
import 'package:game/models/chunk_request.dart';

void main() {
  group('ChunkService', () {
    test('fetchChunk should return rate limit exceeded when exceeded', () async {
      final service = ChunkService();
      final request = ChunkRequest(x: 0, y: 0, z: 0);

      for (var i = 0; i < 61; i++) {
        await service.fetchChunk(request);
      }

      final response = await service.fetchChunk(request);
      expect(response.statusCode, 429);
    });

    test('fetchChunk should return successful response when within limit', () async {
      final service = ChunkService();
      final request = ChunkRequest(x: 0, y: 0, z: 0);

      final response = await service.fetchChunk(request);
      expect(response.statusCode, 200); // Assuming the actual request is successful
    });
  });
}
