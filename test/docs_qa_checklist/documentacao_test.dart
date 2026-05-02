import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/docs/instrucoes.dart';

void main() {
  test('testa presença de seção de controles', () {
    expect(instrucoes.conteudo.contains('## Controles'), true);
  });

  test('testa objetivos claros', () {
    expect(instrucoes.conteudo.contains('## Objetivos'), true);
  });

  test('testa limite de caracteres para a UI', () {
    expect(instrucoes.conteudo.length <= 1000, true);
  });
}
