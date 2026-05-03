enum CharacterState { idle, walking }

class PlayerState {
  CharacterState state;

  PlayerState({this.state = CharacterState.idle});

  void updateState(CharacterState newState) {
    state = newState;
  }
}
