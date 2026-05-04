import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/volume.dart';

void main() {
  group('Volume Tests', () {
    test('should handle zero volume', () {
      expect(Volume(0.0).value, 0.0);
    });

    test('should handle maximum volume', () {
      expect(Volume(1.0).value, 1.0);
    });

    test('should handle null volume', () {
      expect(() => Volume(null), throwsArgumentError);
    });

    test('should handle negative volume', () {
      expect(() => Volume(-1.0), throwsArgumentError);
    });

    test('should handle volume greater than 1.0', () {
      expect(() => Volume(2.0), throwsArgumentError);
    });
  });
}
