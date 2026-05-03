import 'package:game/src/features/player/movement/player_movement_trigger.dart';
import 'package:game/src/features/player/movement/player_state.dart';

class PlayerMovement {
  PlayerState _state = const PlayerState.idle();

  PlayerState get state => _state;

  void handleInput(String input) {
    if (PlayerMovementTriggerHandler.isMovementTrigger(input)) {
      final trigger = PlayerMovementTriggerHandler.fromInput(input);
      if (trigger != null) {
        _state = PlayerState.walking(direction: trigger);
      }
    } else {
      _state = const PlayerState.idle();
    }
  }
}
