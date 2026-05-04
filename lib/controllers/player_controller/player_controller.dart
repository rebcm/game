import 'package:game/models/player_state/player_state.dart';
import 'package:game/services/input_service/input_service.dart';
import 'package:flutter/material.dart';

class PlayerController with ChangeNotifier {
  final PlayerStateMachine _playerStateMachine;
  final InputService _inputService;

  PlayerController(this._playerStateMachine, this._inputService);

  void handleKeyEvent(RawKeyEvent event) {
    if (_inputService.isMovementKeyPressed(event)) {
      _playerStateMachine.transitionToWalking();
    } else {
      _playerStateMachine.transitionToIdle();
    }
    notifyListeners();
  }
}
