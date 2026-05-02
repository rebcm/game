import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';

void main() {
  test('TipoBloco values returns all block types', () {
    expect(TipoBloco.values.length, greaterThan(0));
  });

  test('TipoBloco properties are correctly set', () {
    expect(TipoBloco.grama.nome, 'Grama');
    expect(TipoBloco.grama.cor, isNotNull);
    expect(TipoBloco.grama.solido, true);
    expect(TipoBloco.grama.transparente, false);
    expect(TipoBloco.grama.emiteLuz, false);
  });
}
