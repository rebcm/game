class InputValidator {
  static bool validateInput(String input) {
    const maxLength = 255;
    return input.length <= maxLength;
  }
}
