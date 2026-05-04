import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:game/control_schemes/control_scheme.dart';

class InputManager with ChangeNotifier {
  ControlScheme _currentScheme;

  InputManager(this._currentScheme);

  ControlScheme get currentScheme => _currentScheme;

  void switchScheme(ControlScheme newScheme) {
    _currentScheme = newScheme;
    notifyListeners();
  }

  void handleKeyEvent(RawKeyEvent event) {
    // Implement key event handling based on _currentScheme
  }
}
