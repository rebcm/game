import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('EstadoJogo', () {
    test('dispose cancela todos os Timers ativos', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        // Assume que EstadoJogo inicia timers em initState
        estadoJogo.initState();
        
        // Verifica se os timers estão ativos antes de dispose
        expect(estadoJogo.hasActiveTimers, isTrue);
        
        estadoJogo.dispose();
        
        // Verifica se os timers foram cancelados após dispose
        expect(estadoJogo.hasActiveTimers, isFalse);
      });
    });
  });
}
