import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Volume Persistence Edge Cases', () {
    test('should handle null value', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs), throwsA(isA<Exception>()));
    });

    test('should handle invalid value', () async {
      SharedPreferences.setMockInitialValues({'volume': 'invalid'});
      final prefs = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs), throwsA(isA<Exception>()));
    });

    test('should handle extreme values (0.0 and 1.0)', () async {
      SharedPreferences.setMockInitialValues({'volume': '0.0'});
      final prefs1 = await SharedPreferences.getInstance();
      final volume1 = Volume.fromPersistence(prefs1);
      expect(volume1.value, 0.0);

      SharedPreferences.setMockInitialValues({'volume': '1.0'});
      final prefs2 = await SharedPreferences.getInstance();
      final volume2 = Volume.fromPersistence(prefs2);
      expect(volume2.value, 1.0);
    });

    test('should handle out of range values', () async {
      SharedPreferences.setMockInitialValues({'volume': '-1.0'});
      final prefs1 = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs1), throwsA(isA<Exception>()));

      SharedPreferences.setMockInitialValues({'volume': '2.0'});
      final prefs2 = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs2), throwsA(isA<Exception>()));
    });
  });
}
