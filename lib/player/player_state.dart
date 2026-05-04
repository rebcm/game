enum PlayerState { idle, walking }

class PlayerStateManager with ChangeNotifier {
  PlayerState _state = PlayerState.idle;

  PlayerState get state => _state;

  void setState(PlayerState state) {
    _state = state;
    notifyListeners();
  }

  void updateState(bool isWalking) {
    if (isWalking) {
      setState(PlayerState.walking);
    } else {
      setState(PlayerState.idle);
    }
  }
}
