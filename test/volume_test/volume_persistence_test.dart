import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Volume Persistence Tests', () {
    test('Testa recuperação de volume com valor 0.0', () async {
      SharedPreferences.setMockInitialValues({'volume': 0.0});
      final prefs = await SharedPreferences.getInstance();
      final volume = Volume(prefs);
      expect(volume.value, 0.0);
    });

    test('Testa recuperação de volume com valor 1.0', () async {
      SharedPreferences.setMockInitialValues({'volume': 1.0});
      final prefs = await SharedPreferences.getInstance();
      final volume = Volume(prefs);
      expect(volume.value, 1.0);
    });

    test('Testa recuperação de volume com valor nulo', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final volume = Volume(prefs);
      expect(volume.value, Volume.defaultValue);
    });

    test('Testa recuperação de volume com valor inválido', () async {
      SharedPreferences.setMockInitialValues({'volume': 'invalid'});
      final prefs = await SharedPreferences.getInstance();
      final volume = Volume(prefs);
      expect(volume.value, Volume.defaultValue);
    });
  });
}
