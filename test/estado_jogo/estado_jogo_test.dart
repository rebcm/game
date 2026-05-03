import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:game/estado_jogo.dart';

void main() {
  group('EstadoJogo', () {
    test('dispose cancela todos os Timers ativos', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        // Inicializa timers
        estadoJogo.initState();
        async.flushTimers();
        expect(estadoJogo.mounted, true);

        estadoJogo.dispose();
        async.flushTimers();

        expect(estadoJogo.mounted, false);
      });
    });
  });
}
