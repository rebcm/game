import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:typed_data';
import 'package:archive/archive.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Data Integrity Test', () {
    testWidgets('Original payload is identical to decompressed payload', (tester) async {
      final originalPayload = Uint8List.fromList(List.generate(1024, (index) => index % 256));
      final compressedPayload = GZipEncoder().encode(originalPayload);
      final decompressedPayload = GZipDecoder().decodeBytes(compressedPayload!);

      expect(originalPayload, decompressedPayload);
    });

    testWidgets('Corrupted payload test', (tester) async {
      final originalPayload = Uint8List.fromList(List.generate(1024, (index) => index % 256));
      final compressedPayload = GZipEncoder().encode(originalPayload);
      final corruptedCompressedPayload = Uint8List.fromList(compressedPayload!.sublist(0, compressedPayload.length - 1));

      expect(() => GZipDecoder().decodeBytes(corruptedCompressedPayload), throwsA(isA<ArchiveException>()));
    });
  });
}
