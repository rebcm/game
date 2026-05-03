import 'package:flutter/material.dart';

enum PlayerState { idle, walking }

class PlayerController with ChangeNotifier {
  PlayerState _state = PlayerState.idle;

  PlayerState get state => _state;

  void handleInput(InputEvent event) {
    if (event is KeyboardEvent) {
      if (['W', 'A', 'S', 'D'].contains(event.key)) {
        _state = PlayerState.walking;
        notifyListeners();
      }
    } else if (event is TouchEvent) {
      if (isMovementControl(event.position)) {
        _state = PlayerState.walking;
        notifyListeners();
      }
    }
  }

  bool isMovementControl(Offset position) {
    // Lógica para verificar se o toque foi nos controles de movimentação
    // Implementar lógica real aqui
    return false;
  }
}

class InputEvent {}

class KeyboardEvent extends InputEvent {
  String key;

  KeyboardEvent(this.key);
}

class TouchEvent extends InputEvent {
  Offset position;

  TouchEvent(this.position);
}
