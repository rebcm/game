import 'package:flutter/material.dart';
import 'package:passdriver/features/character_animation/models/character_animation_config.dart';

class CharacterAnimationConfigProvider with ChangeNotifier {
  CharacterAnimationConfig _config = CharacterAnimationConfig(
    tolerance: 0.05,
    maxFrameRate: 60,
    minFrameRate: 30,
  );

  CharacterAnimationConfig get config => _config;

  void updateConfig(CharacterAnimationConfig newConfig) {
    _config = newConfig;
    notifyListeners();
  }
}
