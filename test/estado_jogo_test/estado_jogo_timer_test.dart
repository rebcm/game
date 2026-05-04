import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('EstadoJogo', () {
    test('dispose cancela todos os timers', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        estadoJogo.initState();
        async.flushTimers();
        estadoJogo.dispose();
        expect(estadoJogo._timer?.isActive, isFalse);
      });
    });
  });
}
