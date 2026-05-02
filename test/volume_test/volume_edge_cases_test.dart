import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Volume Edge Cases Test', () {
    test('Testa recuperação de volume com valor 0.0', () async {
      SharedPreferences.setMockInitialValues({'volume': 0.0});
      final volume = await Volume.getVolume();
      expect(volume, 0.0);
    });

    test('Testa recuperação de volume com valor 1.0', () async {
      SharedPreferences.setMockInitialValues({'volume': 1.0});
      final volume = await Volume.getVolume();
      expect(volume, 1.0);
    });

    test('Testa recuperação de volume com valor nulo', () async {
      SharedPreferences.setMockInitialValues({});
      final volume = await Volume.getVolume();
      expect(volume, 0.5); // Valor padrão
    });

    test('Testa recuperação de volume com valor inválido', () async {
      SharedPreferences.setMockInitialValues({'volume': 'invalid'});
      expect(() async => await Volume.getVolume(), throwsA(isA<TypeError>()));
    });
  });
}
