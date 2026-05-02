import 'package:flutter/material.dart';
import 'package:passdriver/features/transitions/models/transition_state.dart';

class TransitionProvider with ChangeNotifier {
  TransitionState _state = TransitionState.idle;

  TransitionState get state => _state;

  void startWalking() {
    _state = TransitionState.walking;
    notifyListeners();
  }

  void stopWalking() {
    _state = TransitionState.idle;
    notifyListeners();
  }

  void startDriving() {
    _state = TransitionState.driving;
    notifyListeners();
  }

  void stopDriving() {
    _state = TransitionState.idle;
    notifyListeners();
  }
}
