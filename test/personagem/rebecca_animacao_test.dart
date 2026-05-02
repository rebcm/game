import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebecca_animacao.dart';

void main() {
  group('AnimacaoRebeca', () {
    test('inicialmente não está sincronizada', () {
      AnimacaoRebeca animacao = AnimacaoRebeca();
      expect(animacao.estaSincronizada(), false);
    });

    test('retorna true quando dentro do desvio máximo permitido', () {
      AnimacaoRebeca animacao = AnimacaoRebeca();
      animacao.atualizar(60, 1);
      expect(animacao.estaSincronizada(), true);
    });

    test('retorna false quando fora do desvio máximo permitido', () {
      AnimacaoRebeca animacao = AnimacaoRebeca();
      animacao.atualizar(10, 10);
      expect(animacao.estaSincronizada(), false);
    });
  });
}
