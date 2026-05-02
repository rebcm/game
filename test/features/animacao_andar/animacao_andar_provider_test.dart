import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/animacao_andar/providers/animacao_andar_provider.dart';

void main() {
  test('validarCriteriosDeAceitacao should return true when criteria are met', () {
    final provider = AnimacaoAndarProvider();
    provider.atualizarAnimacaoAndar(AnimacaoAndar(fps: 30, sincroniaBracoPerna: 0.8, loopAtivo: true));
    expect(provider.validarCriteriosDeAceitacao(), true);
  });

  test('validarCriteriosDeAceitacao should return false when criteria are not met', () {
    final provider = AnimacaoAndarProvider();
    provider.atualizarAnimacaoAndar(AnimacaoAndar(fps: 20, sincroniaBracoPerna: 0.7, loopAtivo: false));
    expect(provider.validarCriteriosDeAceitacao(), false);
  });
}
