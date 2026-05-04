import 'package:flutter_test/flutter_test.dart';
import 'package:game/volume.dart';

void main() {
  group('Volume Tests', () {
    test('should handle zero volume', () {
      final volume = Volume(0.0);
      expect(volume.value, 0.0);
    });

    test('should handle maximum volume', () {
      final volume = Volume(1.0);
      expect(volume.value, 1.0);
    });

    test('should handle null volume', () {
      expect(() => Volume(null), throwsArgumentError);
    });

    test('should handle invalid volume', () {
      expect(() => Volume(-1.0), throwsArgumentError);
      expect(() => Volume(2.0), throwsArgumentError);
    });
  });
}
