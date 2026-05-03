import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/responsividade/resolucoes.dart';

void main() {
  test('Verifica se as resoluções mínimas estão definidas corretamente', () {
    expect(Resolucoes.resolucoesMinimas, isNotEmpty);
    expect(Resolucoes.resolucoesMinimas, contains(320));
    expect(Resolucoes.resolucoesMinimas, contains(360));
  });

  test('Verifica se os dispositivos alvo estão definidos corretamente', () {
    expect(Resolucoes.dispositivosAlvo, isNotEmpty);
    expect(Resolucoes.dispositivosAlvo, contains('iPhone 12'));
    expect(Resolucoes.dispositivosAlvo, contains('Samsung Galaxy S21'));
  });
}
