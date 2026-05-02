import 'package:flutter_test/flutter_test.dart';
import 'package:game/personagem/rebeca.dart';

void main() {
  test('Rebeca inicializa corretamente', () {
    final rebeca = Rebeca();
    expect(rebeca.x, 0);
    expect(rebeca.y, 0);
    expect(rebeca.z, 0);
  });

  test('Rebeca atualiza posição corretamente', () {
    final rebeca = Rebeca();
    rebeca.mover(1, 1);
    rebeca.atualizarPosicao();
    expect(rebeca.x, 1);
    expect(rebeca.z, 1);
  });

  test('Rebeca pula corretamente', () {
    final rebeca = Rebeca();
    rebeca.pular();
    expect(rebeca.getAnimacao(), 'pular');
  });

  test('Rebeca voa corretamente', () {
    final rebeca = Rebeca();
    rebeca.voar();
    expect(rebeca.getAnimacao(), 'voar');
  });
}
