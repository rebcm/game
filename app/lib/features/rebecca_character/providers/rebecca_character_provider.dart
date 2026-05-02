import 'package:flutter/material.dart';
import '../models/rebecca_character_model.dart';

class RebeccaCharacterProvider with ChangeNotifier {
  late RebeccaCharacterModel _rebeccaModel;

  RebeccaCharacterProvider() {
    _rebeccaModel = RebeccaCharacterModel(skinPath: 'assets/characters/rebeca_skin.png');
  }

  RebeccaCharacterModel get rebeccaModel => _rebeccaModel;

  void updateSkin(String newSkinPath) {
    _rebeccaModel = RebeccaCharacterModel(skinPath: newSkinPath);
    notifyListeners();
  }
}
import 'package:construcao_criativa/features/rebecca_character/models/rebecca_idle_animation_config.dart';

class RebeccaCharacterProvider with ChangeNotifier {
  // ... existing code ...

  void _animateIdle() {
    // Implementação da animação idle usando RebeccaIdleAnimationConfig
    final animation = Tween<double>(begin: 0, end: RebeccaIdleAnimationConfig.amplitude)
      .animate(CurvedAnimation(
        parent: _animationController,
        curve: RebeccaIdleAnimationConfig.easingFunction,
      ));

    _animationController.duration = Duration(seconds: RebeccaIdleAnimationConfig.loopDuration.toInt());
    _animationController.repeat();
  }
}
