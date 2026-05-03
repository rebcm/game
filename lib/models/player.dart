import 'package:flutter/animation.dart';
import 'package:game/utils/animation_sync.dart';

class Player with ChangeNotifier {
  double _translationSpeed = 0.0;
  double _animationSpeed = 10.0; // example animation speed
  late AnimationController _animationController;

  Player(this._animationController);

  void updateTranslationSpeed(double speed) {
    _translationSpeed = speed;
    _animationController.value = AnimationSync.calculatePlaybackRate(_translationSpeed, _animationSpeed);
    notifyListeners();
  }
}
