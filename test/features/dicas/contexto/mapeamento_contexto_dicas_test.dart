import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/dicas/contexto/mapeamento_contexto_dicas.dart';

void main() {
  test('deve retornar true para telas com dicas', () {
    expect(MapeamentoContextoDicas.deveMostrarDica('TelaInicial'), true);
    expect(MapeamentoContextoDicas.deveMostrarDica('TelaConstrucao'), true);
  });

  test('deve retornar false para telas sem dicas', () {
    expect(MapeamentoContextoDicas.deveMostrarDica('TelaOutros'), false);
  });

  test('deve retornar Tooltip para TelaInicial', () {
    expect(MapeamentoContextoDicas.obterDica('TelaInicial'), isA<Tooltip>());
  });

  test('deve retornar Modal para TelaConstrucao', () {
    expect(MapeamentoContextoDicas.obterDica('TelaConstrucao'), isA<Modal>());
  });
}
