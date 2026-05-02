import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/estado_rebeca.dart';

void main() {
  group('TransicaoEstadoRebeca', () {
    test('deve permanecer parado quando não há movimento', () {
      final transicao = TransicaoEstadoRebeca(EstadoRebeca.parado, false);
      expect(transicao.proximoEstado(), EstadoRebeca.parado);
    });

    test('deve mudar para andando quando movimento é pressionado', () {
      final transicao = TransicaoEstadoRebeca(EstadoRebeca.parado, true);
      expect(transicao.proximoEstado(), EstadoRebeca.andando);
    });

    test('deve permanecer andando quando movimento continua pressionado', () {
      final transicao = TransicaoEstadoRebeca(EstadoRebeca.andando, true);
      expect(transicao.proximoEstado(), EstadoRebeca.andando);
    });

    test('deve mudar para parado quando movimento é liberado', () {
      final transicao = TransicaoEstadoRebeca(EstadoRebeca.andando, false);
      expect(transicao.proximoEstado(), EstadoRebeca.parado);
    });

    test('deve permanecer parado quando não há movimento pressionado', () {
      final transicao = TransicaoEstadoRebeca(EstadoRebeca.parado, false);
      expect(transicao.proximoEstado(), EstadoRebeca.parado);
    });
  });
}
