import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:your_app/api/chunk_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ChunkApi', () {
    late ChunkApi chunkApi;
    late MockHttpClient mockClient;

    setUp(() {
      mockClient = MockHttpClient();
      chunkApi = ChunkApi(mockClient);
    });

    test('getChunk returns Chunk when response is 200', () async {
      final chunk = Chunk(id: 1, data: 'test data');
      when(mockClient.get(Uri.parse('/chunks/1')))
          .thenAnswer((_) async => http.Response(jsonEncode(chunk.toJson()), 200));

      final result = await chunkApi.getChunk(1);
      expect(result.id, chunk.id);
      expect(result.data, chunk.data);
    });

    test('getChunk throws Exception when response is not 200', () async {
      when(mockClient.get(Uri.parse('/chunks/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await chunkApi.getChunk(1), throwsException);
    });

    test('createChunk returns Chunk when response is 201', () async {
      final chunk = Chunk(id: 1, data: 'test data');
      when(mockClient.post(Uri.parse('/chunks'),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(jsonEncode(chunk.toJson()), 201));

      final result = await chunkApi.createChunk(chunk);
      expect(result.id, chunk.id);
      expect(result.data, chunk.data);
    });

    test('createChunk throws Exception when response is not 201', () async {
      final chunk = Chunk(id: 1, data: 'test data');
      when(mockClient.post(Uri.parse('/chunks'),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      expect(() async => await chunkApi.createChunk(chunk), throwsException);
    });
  });
}
