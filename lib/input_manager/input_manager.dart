import 'package:flutter/services.dart';
import 'package:game/control_schemes/control_scheme.dart';

class InputManager {
  ControlScheme _currentScheme;

  InputManager(this._currentScheme);

  void switchScheme(ControlScheme newScheme) {
    _currentScheme = newScheme;
  }

  void handleKeyEvent(RawKeyEvent event) {
    _currentScheme.handleKeyEvent(event);
  }
}
