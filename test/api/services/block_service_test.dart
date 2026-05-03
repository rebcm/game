import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../lib/api/services/block_service.dart';
import '../../lib/api/models/block.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('BlockService', () {
    late BlockService blockService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      blockService = BlockService();
    });

    test('getBlocks returns a list of blocks when the response is 200', () async {
      // Arrange
      when(() => mockHttpClient.get(Uri.parse('https://example.com/blocks')))
          .thenAnswer((_) async => http.Response('[{"id": 1, "name": "Block 1"}]', 200));

      // Act
      final blocks = await blockService.getBlocks();

      // Assert
      expect(blocks, isA<List<Block>>());
      expect(blocks.length, 1);
    });
  });
}
