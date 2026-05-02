import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Testes de configurações', () {
    test('Verifica se a autora está correta', () {
      expect(Constantes.autora, 'Rebeca Alves Moreira');
    });

    test('Verifica se a versão do jogo está correta', () {
      expect(Constantes.versao, '1.0.0');
    });
  });
}
