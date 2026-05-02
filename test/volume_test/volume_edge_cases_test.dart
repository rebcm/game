import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/volume.dart';

void main() {
  group('Volume Edge Cases', () {
    test('should handle null values', () {
      expect(() => Volume.fromJson(null), throwsArgumentError);
    });

    test('should handle extreme values', () {
      final volume = Volume.fromJson({'value': 0.0});
      expect(volume.value, 0.0);

      final volume2 = Volume.fromJson({'value': 1.0});
      expect(volume2.value, 1.0);
    });

    test('should handle invalid values', () {
      expect(() => Volume.fromJson({'value': -1.0}), throwsArgumentError);
      expect(() => Volume.fromJson({'value': 2.0}), throwsArgumentError);
    });
  });
}
