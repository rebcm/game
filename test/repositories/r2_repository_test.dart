import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/models/chunk_model.dart';
import 'package:rebcm/repositories/r2_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late R2Repository r2Repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    r2Repository = R2Repository(mockHttpClient);
  });

  group('R2Repository', () {
    test('should upload chunk', () async {
      final chunk = ChunkModel(id: 'chunk-id', data: 'chunk-data');
      when(() => mockHttpClient.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response('', 201));

      await r2Repository.uploadChunk(chunk);
      verify(() => mockHttpClient.post(Uri.parse('https://example-r2.com/chunks'), body: chunk.toJson())).called(1);
    });
  });
}
