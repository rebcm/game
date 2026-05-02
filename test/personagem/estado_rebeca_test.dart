import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/estado_rebeca.dart';

void main() {
  group('MaquinaEstadoRebeca', () {
    test('inicia no estado parado', () {
      final maquina = MaquinaEstadoRebeca();
      expect(maquina.estado, EstadoRebeca.parado);
    });

    test('transita para andando quando movimentando', () {
      final maquina = MaquinaEstadoRebeca();
      maquina.atualizar(true);
      expect(maquina.estado, EstadoRebeca.andando);
    });

    test('transita para parado quando para de movimentar', () {
      final maquina = MaquinaEstadoRebeca();
      maquina.atualizar(true);
      maquina.atualizar(false);
      expect(maquina.estado, EstadoRebeca.parado);
    });

    test('não muda de estado quando continua movimentando', () {
      final maquina = MaquinaEstadoRebeca();
      maquina.atualizar(true);
      maquina.atualizar(true);
      expect(maquina.estado, EstadoRebeca.andando);
    });

    test('não muda de estado quando continua parado', () {
      final maquina = MaquinaEstadoRebeca();
      maquina.atualizar(false);
      maquina.atualizar(false);
      expect(maquina.estado, EstadoRebeca.parado);
    });
  });
}
