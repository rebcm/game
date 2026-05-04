class InputValidator {
  bool validateInput(dynamic input) {
    // Implementação da validação de input
    if (input is LogicalKeyboardKey) {
      return input != LogicalKeyboardKey.f1;
    } else if (input is TapEvent) {
      return true;
    }
    return false;
  }
}

