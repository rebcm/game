import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Testes de Configurações', () {
    test('Verifica se as constantes estão corretas', () {
      expect(Constantes.autora, 'Rebeca Alves Moreira');
    });

    test('Testa inicialização das preferências compartilhadas', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(prefs, isNotNull);
    });

    test('Verifica se as configurações iniciais são válidas', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('som_ativo'), isNull);
    });
  });
}
