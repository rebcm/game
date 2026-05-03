import 'package:flutter/services.dart';
import 'package:game/player/player_state.dart';

class InputHandler {
  final PlayerState playerState;

  InputHandler(this.playerState);

  void handleKeyEvent(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.keyW) ||
        event.isKeyPressed(LogicalKeyboardKey.keyA) ||
        event.isKeyPressed(LogicalKeyboardKey.keyS) ||
        event.isKeyPressed(LogicalKeyboardKey.keyD)) {
      playerState.updateState(CharacterState.walking);
    } else {
      playerState.updateState(CharacterState.idle);
    }
  }

  void handleTouchEvent(TouchEvent event) {
    if (event.type == TouchEventType.move) {
      playerState.updateState(CharacterState.walking);
    } else if (event.type == TouchEventType.end) {
      playerState.updateState(CharacterState.idle);
    }
  }
}
