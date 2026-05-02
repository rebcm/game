import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Testes de Configuração de Ambiente', () {
    test('Verifica se as constantes de ambiente estão corretas', () {
      expect(Constantes.autora, 'Rebeca Alves Moreira');
    });

    test('Verifica se o ambiente está configurado corretamente', () {
      expect(Constantes.versao, '1.0.0');
    });
  });
}
