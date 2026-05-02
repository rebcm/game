import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Volume Edge Cases Test', () {
    test('Test volume with extreme values (0.0 and 1.0)', () async {
      SharedPreferences.setMockInitialValues({});
      await Volume().save(0.0);
      expect(await Volume().load(), 0.0);
      await Volume().save(1.0);
      expect(await Volume().load(), 1.0);
    });

    test('Test volume with null value', () async {
      SharedPreferences.setMockInitialValues({'volume': null});
      expect(await Volume().load(), Volume().defaultValue);
    });

    test('Test volume with invalid value', () async {
      SharedPreferences.setMockInitialValues({'volume': 'invalid'});
      expect(await Volume().load(), Volume().defaultValue);
    });
  });
}
