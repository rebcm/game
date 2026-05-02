import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Testes de Configuração de Ambiente', () {
    test('Verifica se as constantes estão corretas', () {
      expect(Constantes.autora, 'Rebeca Alves Moreira');
    });

    test('Testa inicialização do SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(prefs, isNotNull);
    });
  });
}
