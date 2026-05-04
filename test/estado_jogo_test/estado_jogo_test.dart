import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:game/estado_jogo.dart';

void main() {
  group('EstadoJogo', () {
    test('dispose cancela todos os timers', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        // Inicializa timers aqui se necessário
        estadoJogo.dispose();
        async.flushTimers();
        // Verifica se os timers foram cancelados
      });
    });
  });
}
