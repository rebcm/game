import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/dicas/contexto/mapeamento_contexto.dart';

void main() {
  group('MapeamentoContexto', () {
    test('deve retornar true para telas com dicas configuradas', () {
      expect(MapeamentoContexto.deveMostrarDica('TelaInicial', 'botaoIniciarConstrucao'), true);
      expect(MapeamentoContexto.deveMostrarDica('TelaConstrucao', 'acaoConstruirBloco'), true);
    });

    test('deve retornar false para telas sem dicas configuradas', () {
      expect(MapeamentoContexto.deveMostrarDica('TelaDesconhecida', 'gatilhoQualquer'), false);
    });

    test('deve retornar o tipo correto de dica', () {
      expect(MapeamentoContexto.tipoDica('TelaInicial', 'botaoIniciarConstrucao'), 'Modal');
      expect(MapeamentoContexto.tipoDica('TelaConstrucao', 'acaoConstruirBloco'), 'Tooltip');
    });

    test('deve retornar null para gatilhos sem tipo de dica definido', () {
      expect(MapeamentoContexto.tipoDica('TelaConstrucao', 'gatilhoDesconhecido'), null);
    });
  });
}
