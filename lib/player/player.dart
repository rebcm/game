import 'package:flutter/material.dart';

enum PlayerState { idle, walking }
enum PlayerAnimation { idle, walking }

class Player with ChangeNotifier {
  PlayerState _state = PlayerState.idle;

  PlayerState get state => _state;

  void updateState(PlayerState? newState) {
    if (newState != null && newState != _state) {
      _state = newState;
      updateAnimation(_state == PlayerState.idle ? PlayerAnimation.idle : PlayerAnimation.walking);
      notifyListeners();
    }
  }

  void updateAnimation(PlayerAnimation animation) {
    // Logic to update the player's animation
  }
}
