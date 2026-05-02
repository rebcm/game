import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/animacao_andar/providers/animacao_andar_provider.dart';

void main() {
  test('deve retornar true quando a animação está dentro dos critérios de aceitação', () {
    final provider = AnimacaoAndarProvider();
    provider.atualizarAnimacaoAndar(
      AnimacaoAndar(
        fps: 30,
        sincroniaBracoPerna: 0.9,
        loopAtivo: true,
      ),
    );

    expect(provider.estaDentroDosCriteriosDeAceitacao, true);
  });

  test('deve retornar false quando a animação não está dentro dos critérios de aceitação', () {
    final provider = AnimacaoAndarProvider();
    provider.atualizarAnimacaoAndar(
      AnimacaoAndar(
        fps: 15,
        sincroniaBracoPerna: 0.7,
        loopAtivo: false,
      ),
    );

    expect(provider.estaDentroDosCriteriosDeAceitacao, false);
  });
}
