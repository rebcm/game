enum PlayerState { idle, walk, run }

class Player with ChangeNotifier {
  PlayerState _state = PlayerState.idle;

  PlayerState get state => _state;

  void idle() {
    _state = PlayerState.idle;
    notifyListeners();
  }

  void walk() {
    _state = PlayerState.walk;
    notifyListeners();
  }

  void run() {
    _state = PlayerState.run;
    notifyListeners();
  }
}
