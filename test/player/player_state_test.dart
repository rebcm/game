import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player_state.dart';

void main() {
  group('PlayerState', () {
    test('initial state is idle', () {
      final playerState = PlayerState();
      expect(playerState.state, CharacterState.idle);
    });

    test('update state to walking', () {
      final playerState = PlayerState();
      playerState.updateState(CharacterState.walking);
      expect(playerState.state, CharacterState.walking);
    });

    test('update state to idle', () {
      final playerState = PlayerState();
      playerState.updateState(CharacterState.walking);
      playerState.updateState(CharacterState.idle);
      expect(playerState.state, CharacterState.idle);
    });
  });
}
