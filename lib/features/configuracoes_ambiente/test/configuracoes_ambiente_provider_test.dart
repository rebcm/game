import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/configuracoes_ambiente/configuracoes_ambiente_provider.dart';

void main() {
  group('ConfiguracoesAmbienteProvider', () {
    test('deve iniciar com ambiente de producao', () {
      final provider = ConfiguracoesAmbienteProvider();
      expect(provider.ambiente, 'producao');
    });

    test('deve mudar ambiente', () {
      final provider = ConfiguracoesAmbienteProvider();
      provider.mudarAmbiente('homologacao');
      expect(provider.ambiente, 'homologacao');
    });
  });
}
