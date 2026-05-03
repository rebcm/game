import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player.dart';
import 'package:mockito/mockito.dart';

class MockPlayer extends Mock implements Player {}

void main() {
  late Player player;

  setUp(() {
    player = MockPlayer();
  });

  test('should transition smoothly from Idle to Walking', () {
    when(player.state).thenReturn(PlayerState.idle);
    player.updateState(PlayerState.walking);
    verify(player.updateAnimation(PlayerAnimation.walking)).called(1);
    expect(player.state, PlayerState.walking);
  });

  test('should transition smoothly from Walking to Idle', () {
    when(player.state).thenReturn(PlayerState.walking);
    player.updateState(PlayerState.idle);
    verify(player.updateAnimation(PlayerAnimation.idle)).called(1);
    expect(player.state, PlayerState.idle);
  });

  test('should not transition to invalid state', () {
    when(player.state).thenReturn(PlayerState.idle);
    player.updateState(null);
    verifyNever(player.updateAnimation(any));
    expect(player.state, PlayerState.idle);
  });
}
