import 'package:flutter_test/flutter_test.dart';
import 'package:game/compression.dart';

void main() {
  group('Compression Edge Cases', () {
    test('compressing empty payload', () async {
      final compressed = await compress(Uint8List(0));
      expect(compressed.length, greaterThan(0)); // Assuming some overhead
    });

    test('compressing extremely small payload', () async {
      final payload = Uint8List.fromList([1]);
      final compressed = await compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });

    test('compressing high entropy payload', () async {
      final payload = Uint8List.fromList(List.generate(1024, (_) => (DateTime.now().millisecondsSinceEpoch + _).toByte())); 
      final compressed = await compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });
  });
}
