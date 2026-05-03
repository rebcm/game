import 'package:flutter/material.dart';
import 'package:game/models/player_state_machine/player_state_machine.dart';

class PlayerController with ChangeNotifier {
  PlayerStateMachine _state = const PlayerStateMachine.idle();

  PlayerStateMachine get state => _state;

  void startWalking() {
    _state = const PlayerStateMachine.walking();
    notifyListeners();
  }

  void stopWalking() {
    _state = const PlayerStateMachine.stopping();
    notifyListeners();
  }

  void stop() {
    _state = const PlayerStateMachine.idle();
    notifyListeners();
  }
}
