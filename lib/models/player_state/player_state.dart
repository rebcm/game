enum PlayerState { idle, walking }

class PlayerStateMachine {
  PlayerState _state = PlayerState.idle;

  PlayerState get state => _state;

  void transitionToWalking() {
    _state = PlayerState.walking;
  }

  void transitionToIdle() {
    _state = PlayerState.idle;
  }
}
