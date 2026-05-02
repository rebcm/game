import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/estado_rebeca.dart';

void main() {
  group('TransicaoEstadoRebeca', () {
    test('deve permanecer parado sem input de movimentação', () {
      final transicao = TransicaoEstadoRebeca(estadoAtual: EstadoRebeca.parado, inputMovimentacao: false);
      expect(transicao.transicionar(), EstadoRebeca.parado);
    });

    test('deve mudar para andando com input de movimentação', () {
      final transicao = TransicaoEstadoRebeca(estadoAtual: EstadoRebeca.parado, inputMovimentacao: true);
      expect(transicao.transicionar(), EstadoRebeca.andando);
    });

    test('deve permanecer andando com input de movimentação', () {
      final transicao = TransicaoEstadoRebeca(estadoAtual: EstadoRebeca.andando, inputMovimentacao: true);
      expect(transicao.transicionar(), EstadoRebeca.andando);
    });

    test('deve mudar para parado sem input de movimentação', () {
      final transicao = TransicaoEstadoRebeca(estadoAtual: EstadoRebeca.andando, inputMovimentacao: false);
      expect(transicao.transicionar(), EstadoRebeca.parado);
    });
  });
}
