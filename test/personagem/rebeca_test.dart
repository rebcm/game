import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/personagem/estado_rebeca.dart';

void main() {
  group('Rebeca', () {
    test('atualiza estado corretamente', () {
      final state = RebecaState();
      final rebeca = Rebeca(state);
      rebeca.atualizar(true);
      expect(rebeca.estado, EstadoRebeca.andando);
      rebeca.atualizar(false);
      expect(rebeca.estado, EstadoRebeca.parado);
    });
  });
}
