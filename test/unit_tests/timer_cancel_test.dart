import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:game/estado_jogo.dart';

void main() {
  group('EstadoJogo Timer Cancellation Tests', () {
    test('dispose() should cancel all active Timers', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo();
        estadoJogo.initState(); // Assume initState initializes timers

        async.elapse(Duration(seconds: 1)); // Advance time to simulate timer activity

        estadoJogo.dispose();

        async.elapse(Duration(seconds: 1)); // Check if timers are cancelled

        // Verify that timers are not fired after dispose
        // Implementation depends on how timers are used in EstadoJogo
        // For example, if EstadoJogo has a callback or a flag to check
        expect(estadoJogo.someFlagOrCallbackFired, false);
      });
    });
  });
}
