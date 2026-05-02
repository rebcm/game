import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/transitions/providers/transition_provider.dart';

void main() {
  group('TransitionProvider', () {
    late TransitionProvider provider;

    setUp(() {
      provider = TransitionProvider();
    });

    test('initial state is idle', () {
      expect(provider.state, TransitionState.idle);
    });

    test('startWalking sets state to walking', () {
      provider.startWalking();
      expect(provider.state, TransitionState.walking);
    });

    test('stopWalking sets state to idle', () {
      provider.startWalking();
      provider.stopWalking();
      expect(provider.state, TransitionState.idle);
    });

    test('startDriving sets state to driving', () {
      provider.startDriving();
      expect(provider.state, TransitionState.driving);
    });

    test('stopDriving sets state to idle', () {
      provider.startDriving();
      provider.stopDriving();
      expect(provider.state, TransitionState.idle);
    });
  });
}
