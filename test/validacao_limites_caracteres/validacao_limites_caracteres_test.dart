import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/validacao_limites_caracteres.dart';

void main() {
  group('ValidacaoLimitesCaracteres', () {
    test('deve aceitar input dentro do limite de caracteres', () {
      final input = 'a' * 100;
      expect(ValidacaoLimitesCaracteres.validar(input, 100), true);
    });

    test('deve rejeitar input com limite de caracteres excedido', () {
      final input = 'a' * 101;
      expect(ValidacaoLimitesCaracteres.validar(input, 100), false);
    });

    test('deve aceitar input vazio quando limite é zero', () {
      final input = '';
      expect(ValidacaoLimitesCaracteres.validar(input, 0), true);
    });

    test('deve rejeitar input não vazio quando limite é zero', () {
      final input = 'a';
      expect(ValidacaoLimitesCaracteres.validar(input, 0), false);
    });
  });
}
