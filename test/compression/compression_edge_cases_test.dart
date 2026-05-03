import 'package:flutter_test/flutter_test.dart';
import 'package:game/compression.dart';

void main() {
  group('Compressão Edge Cases', () {
    test('Payload vazio', () async {
      final compressed = compress(Uint8List(0));
      expect(compressed, isNotNull);
      expect(compressed.length, isNonZero);
    });

    test('Payload extremamente pequeno', () async {
      final payload = Uint8List.fromList([1]);
      final compressed = compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });

    test('Payload com alta entropia', () async {
      final payload = Uint8List.fromList(List.generate(100, (_) => (DateTime.now().millisecondsSinceEpoch + _).toByte())); 
      final compressed = compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });
  });
}
