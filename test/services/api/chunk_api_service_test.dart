import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/api/chunk_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ChunkApiService chunkApiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    chunkApiService = ChunkApiService();
  });

  group('getChunk', () {
    test('returns chunk when response is 200', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response('{"x": 1, "z": 1, "data": [1, 2, 3]}', 200));

      // Act
      final chunk = await chunkApiService.getChunk('worldId', 1, 1);

      // Assert
      expect(chunk?.x, 1);
      expect(chunk?.z, 1);
      expect(chunk?.data, [1, 2, 3]);
    });

    test('returns null when response is not 200', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response('', 404));

      // Act
      final chunk = await chunkApiService.getChunk('worldId', 1, 1);

      // Assert
      expect(chunk, null);
    });
  });

  group('saveChunk', () {
    test('returns true when response is 200', () async {
      // Arrange
      when(() => mockHttpClient.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await chunkApiService.saveChunk('worldId', 1, 1, ChunkModel(x: 1, z: 1, data: [1, 2, 3]));

      // Assert
      expect(result, true);
    });

    test('returns false when response is not 200', () async {
      // Arrange
      when(() => mockHttpClient.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 404));

      // Act
      final result = await chunkApiService.saveChunk('worldId', 1, 1, ChunkModel(x: 1, z: 1, data: [1, 2, 3]));

      // Assert
      expect(result, false);
    });
  });
}
