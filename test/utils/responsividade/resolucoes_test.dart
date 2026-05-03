import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/responsividade/resolucoes.dart';

void main() {
  test('Verifica se as resoluções mínimas estão corretas', () {
    expect(Resolucoes.resolucoesMinimas, [320, 360, 375, 414, 768]);
  });

  test('Verifica se os dispositivos alvo estão corretos', () {
    expect(Resolucoes.dispositivosAlvo, ['iPhone 12', 'Samsung Galaxy S21', 'Google Pixel 6']);
  });
}
