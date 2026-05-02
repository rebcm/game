import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Testes de Configurações de Ambiente', () {
    test('Verifica se as constantes estão sendo carregadas corretamente', () {
      expect(Constantes.autora, 'Rebeca Alves Moreira');
    });

    test('Verifica se o tamanho do bloco está correto', () {
      expect(Constantes.tamanhoBloco, 1.0);
    });
  });
}
