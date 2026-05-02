import 'package:test/test.dart';
import 'package:rebcm/services/compression_service.dart';

void main() {
  group('Compression Edge Cases', () {
    test('should not compress payloads smaller than overhead', () async {
      final compressionService = CompressionService();
      final smallPayload = List<int>.generate(10, (index) => index);
      final compressed = await compressionService.compress(smallPayload);
      expect(compressed.length, greaterThan(smallPayload.length));
    });

    test('should handle corrupted chunks', () async {
      final compressionService = CompressionService();
      final payload = List<int>.generate(100, (index) => index);
      final compressed = await compressionService.compress(payload);
      compressed[0] = 255; // Corrupt the first byte
      expect(() async => await compressionService.decompress(compressed), throwsA(isA<Exception>()));
    });
  });
}
