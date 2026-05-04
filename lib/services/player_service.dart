import 'package:flutter/material.dart';
import 'package:game/widgets/player_model.dart';

class PlayerService with ChangeNotifier {
  bool _isWalking = false;

  bool get isWalking => _isWalking;

  void updatePlayerMovement(bool isWalking) {
    _isWalking = isWalking;
    notifyListeners();
  }

  Widget buildPlayerModel() {
    return PlayerModel();
  }
}
