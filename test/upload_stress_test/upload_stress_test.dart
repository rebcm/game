import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/mundo/chunk.dart';
import 'package:rebcm/mundo/upload_manager.dart';

void main() {
  group('Upload Stress Test', () {
    late MockClient _mockClient;
    late UploadManager _uploadManager;

    setUp(() {
      _mockClient = MockClient();
      _uploadManager = UploadManager(_mockClient);
    });

    test('should handle multiple chunk uploads simultaneously', () async {
      // Arrange
      final chunks = List.generate(10, (index) => Chunk(index, List.filled(16 * 16 * 16, 0)));
      final responses = List.generate(10, (index) => http.Response('OK', 200));

      when(() => _mockClient.post(any())).thenAnswer((_) async => responses.removeAt(0));

      // Act
      await Future.wait(chunks.map((chunk) => _uploadManager.uploadChunk(chunk)));

      // Assert
      verify(() => _mockClient.post(any())).called(10);
    });

    test('should handle large chunk uploads', () async {
      // Arrange
      final largeChunk = Chunk(0, List.filled(32 * 32 * 32, 0));
      final response = http.Response('OK', 200);

      when(() => _mockClient.post(any())).thenAnswer((_) async => response);

      // Act
      await _uploadManager.uploadChunk(largeChunk);

      // Assert
      verify(() => _mockClient.post(any())).called(1);
    });
  });
}
