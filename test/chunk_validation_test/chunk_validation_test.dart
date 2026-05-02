import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/chunk_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Chunk Validation Tests', () {
    late http.Client client;
    late ChunkService chunkService;

    setUp(() {
      client = MockHttpClient();
      chunkService = ChunkService(client);
    });

    test('should accept valid chunk file format', () async {
      // Arrange
      final validChunkFile = 'valid_chunk_file';
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('OK', 200));

      // Act
      final response = await chunkService.uploadChunk(validChunkFile);

      // Assert
      expect(response.statusCode, 200);
      verify(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).called(1);
    });

    test('should reject invalid chunk file format', () async {
      // Arrange
      final invalidChunkFile = 'invalid_chunk_file';
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act
      final response = await chunkService.uploadChunk(invalidChunkFile);

      // Assert
      expect(response.statusCode, 400);
      verify(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).called(1);
    });
  });
}
