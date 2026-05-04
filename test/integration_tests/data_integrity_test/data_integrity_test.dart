import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Data Integrity Test', () {
    testWidgets('Original payload equals decompressed payload', (tester) async {
      final originalPayload = Uint8List.fromList(utf8.encode('test_payload'));
      final compressedPayload = gzip.encode(originalPayload);
      final decompressedPayload = gzip.decode(compressedPayload);

      expect(originalPayload, decompressedPayload);
    });

    testWidgets('Corrupted payload test', (tester) async {
      final originalPayload = Uint8List.fromList(utf8.encode('test_payload'));
      final compressedPayload = gzip.encode(originalPayload);
      final corruptedCompressedPayload = Uint8List.fromList(compressedPayload.sublist(0, compressedPayload.length - 1));

      expect(() => gzip.decode(corruptedCompressedPayload), throwsA(isA<FormatException>()));
    });
  });
}
