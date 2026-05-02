import 'package:flutter/material.dart';

class RebeccaCharacterModel with ChangeNotifier {
  String _skinPath = 'assets/characters/rebeca_skin.png';
  String get skinPath => _skinPath;

  // Add animation and control logic here
  String _currentAnimation = 'idle';
  String get currentAnimation => _currentAnimation;

  void updateAnimation(String animation) {
    _currentAnimation = animation;
    notifyListeners();
  }
}
