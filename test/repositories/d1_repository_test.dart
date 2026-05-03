import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/repositories/d1_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late D1Repository d1Repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    d1Repository = D1Repository(mockHttpClient);
  });

  group('D1Repository', () {
    test('should delete chunk record', () async {
      final chunkId = 'chunk-id';
      when(() => mockHttpClient.delete(any())).thenAnswer((_) async => http.Response('', 200));

      await d1Repository.deleteChunkRecord(chunkId);
      verify(() => mockHttpClient.delete(Uri.parse('https://example-d1.com/chunks/$chunkId'))).called(1);
    });
  });
}
