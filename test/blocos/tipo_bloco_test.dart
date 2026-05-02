import 'package:flutter_test/flutter_test.dart';
import 'package:game/blocos/tipo_bloco.dart';

void main() {
  test('verifica se todos os blocos têm nome e cor', () {
    for (var tipo in TipoBloco.values) {
      expect(tipo.nome, isNotEmpty);
      expect(tipo.cor, isNotNull);
    }
  });

  test('verifica propriedades dos blocos', () {
    expect(TipoBloco.grama.solido, true);
    expect(TipoBloco.ar.transparente, true);
    expect(TipoBloco.diamante.emiteLuz, false);
  });
}
