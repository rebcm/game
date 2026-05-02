import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Volume Persistence Tests', () {
    test('should handle null value', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs), throwsAssertionError);
    });

    test('should handle extreme values (0.0 and 1.0)', () async {
      SharedPreferences.setMockInitialValues({'volume': 0.0});
      var prefs = await SharedPreferences.getInstance();
      expect(Volume.fromPersistence(prefs).value, 0.0);

      SharedPreferences.setMockInitialValues({'volume': 1.0});
      prefs = await SharedPreferences.getInstance();
      expect(Volume.fromPersistence(prefs).value, 1.0);
    });

    test('should handle invalid values', () async {
      SharedPreferences.setMockInitialValues({'volume': -1.0});
      var prefs = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs), throwsAssertionError);

      SharedPreferences.setMockInitialValues({'volume': 2.0});
      prefs = await SharedPreferences.getInstance();
      expect(() => Volume.fromPersistence(prefs), throwsAssertionError);
    });
  });
}
