import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:game/state/jogo_state.dart';

void main() {
  group('JogoState', () {
    test('dispose cancels all timers', () {
      fakeAsync((async) {
        final state = JogoState();
        state.initState(); // Assume this starts some timers
        state.dispose();
        async.flushTimers();
        // Verify that no timers are still active after dispose
        expect(async.periodicTimerCount, 0);
      });
    });
  });
}
