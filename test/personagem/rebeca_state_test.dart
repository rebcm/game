import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/estado_rebeca.dart';

void main() {
  group('RebecaState', () {
    test('inicia no estado parado', () {
      final state = RebecaState();
      expect(state.estado, EstadoRebeca.parado);
    });

    test('atualiza para andando quando movimentando', () {
      final state = RebecaState();
      state.atualizarEstado(true);
      expect(state.estado, EstadoRebeca.andando);
    });

    test('atualiza para parado quando não movimentando', () {
      final state = RebecaState();
      state.atualizarEstado(true);
      state.atualizarEstado(false);
      expect(state.estado, EstadoRebeca.parado);
    });

    test('permanece parado quando continua não movimentando', () {
      final state = RebecaState();
      state.atualizarEstado(false);
      state.atualizarEstado(false);
      expect(state.estado, EstadoRebeca.parado);
    });

    test('permanece andando quando continua movimentando', () {
      final state = RebecaState();
      state.atualizarEstado(true);
      state.atualizarEstado(true);
      expect(state.estado, EstadoRebeca.andando);
    });
  });
}
