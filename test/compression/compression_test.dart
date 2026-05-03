import 'package:flutter_test/flutter_test.dart';
import 'package:game/compression.dart';

void main() {
  group('Compression Tests', () {
    test('compress empty payload', () async {
      final compressed = await compress(Uint8List(0));
      expect(compressed.length, greaterThan(0));
    });

    test('compress extremely small payload', () async {
      final payload = Uint8List.fromList([1]);
      final compressed = await compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });

    test('compress high entropy payload', () async {
      final payload = Uint8List.fromList(List.generate(100, (_) => (DateTime.now().millisecondsSinceEpoch + _).toByte())); 
      final compressed = await compress(payload);
      expect(compressed.length, greaterThanOrEqualTo(payload.length));
    });

    test('compress normal payload', () async {
      final payload = Uint8List.fromList(List.generate(100, (_) => _ ~/ 2));
      final compressed = await compress(payload);
      expect(compressed.length, lessThan(payload.length));
    });
  });
}
