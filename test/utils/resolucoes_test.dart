import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/resolucoes.dart';

void main() {
  test('Testa lista de resoluções mínimas', () {
    expect(Resolucoes.resolucoesMinimas, [320, 360, 375, 414, 768, 1024]);
  });

  test('Testa lista de dispositivos alvo', () {
    expect(Resolucoes.dispositivosAlvo, ['iPhone 12', 'Samsung Galaxy S21', 'Google Pixel 6']);
  });
}
