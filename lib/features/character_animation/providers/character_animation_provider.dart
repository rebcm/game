import 'package:flutter/material.dart';
import 'package:passdriver/features/character_animation/models/character_animation_config.dart';
class CharacterAnimationProvider with ChangeNotifier {
  late CharacterAnimationConfig _config;
  CharacterAnimationProvider() {_config = CharacterAnimationConfig(maxTranslationSpeed: 10.0, maxFrameRate: 60.0, tolerance: 0.1);}
  CharacterAnimationConfig get config => _config;
  void updateConfig(CharacterAnimationConfig config) {_config = config; notifyListeners();}
}
