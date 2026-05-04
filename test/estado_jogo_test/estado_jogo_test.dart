import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('EstadoJogo', () {
    test('dispose cancela todos os Timers ativos', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        // Simula a criação de timers
        estadoJogo.iniciarTimers();
        // Verifica se os timers estão ativos antes de dispose
        expect(estadoJogo.temTimersAtivos(), true);
        // Chama dispose dentro do fakeAsync para controlar o tempo
        estadoJogo.dispose();
        // Avança o tempo para garantir que os timers sejam cancelados
        async.elapse(Duration.zero);
        // Verifica se os timers foram cancelados após dispose
        expect(estadoJogo.temTimersAtivos(), false);
      });
    });
  });
}
