import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/configuracoes/ambiente_config.dart';

void main() {
  group('AmbienteConfig', () {
    test('deve carregar configurações corretamente', () async {
      final configuracoes = AmbienteConfig();
      await configuracoes.carregarConfiguracoes();
      expect(configuracoes.versao, isNotEmpty);
    });

    test('deve retornar valores padrão quando não configurado', () {
      final configuracoes = AmbienteConfig();
      expect(configuracoes.versao, '');
    });
  });
}
