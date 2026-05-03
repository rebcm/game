import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:game/state/jogo_state.dart';

void main() {
  group('JogoState', () {
    test('dispose should cancel all timers', () {
      fakeAsync((async) {
        final state = JogoState();
        state.initState();
        async.flushTimers();
        state.dispose();
        expect(state._timer?.isActive, false);
      });
    });
  });
}
