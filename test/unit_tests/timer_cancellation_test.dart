import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:rebcm/game_estado.dart'; // Assuming the state_jogo.dart is in rebcm package

void main() {
  group('Timer Cancellation Tests', () {
    test('dispose() cancels all timers', () {
      fakeAsync((async) {
        final estadoJogo = EstadoJogo(); // Initialize EstadoJogo
        // Assuming EstadoJogo has a method to start timers
        estadoJogo.startTimers();
        async.elapse(Duration(seconds: 1)); // Elapse some time to ensure timers are active
        estadoJogo.dispose(); // Call dispose
        async.elapse(Duration.zero); // Check if timers are cancelled
        // Verify that timers are cancelled
        // This might involve checking the callback count or other side effects
      });
    });
  });
}
