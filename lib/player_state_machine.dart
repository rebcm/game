enum PlayerState { idle, walk, run }
enum PlayerInput { none, walk, run }

class PlayerStateMachine {
  PlayerState _currentState = PlayerState.idle;

  PlayerState get currentState => _currentState;

  void handleInput(PlayerInput input) {
    switch (_currentState) {
      case PlayerState.idle:
        if (input == PlayerInput.walk) {
          _currentState = PlayerState.walk;
        } else if (input == PlayerInput.run) {
          _currentState = PlayerState.run;
        }
        break;
      case PlayerState.walk:
        if (input == PlayerInput.run) {
          _currentState = PlayerState.run;
        } else if (input == PlayerInput.none) {
          _currentState = PlayerState.idle;
        }
        break;
      case PlayerState.run:
        if (input == PlayerInput.walk) {
          _currentState = PlayerState.walk;
        } else if (input == PlayerInput.none) {
          _currentState = PlayerState.idle;
        }
        break;
    }
  }
}
