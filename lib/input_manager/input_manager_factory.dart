import 'input_manager.dart';
import 'keyboard_input_manager.dart';

class InputManagerFactory {
  static InputManager createInputManager() {
    return KeyboardInputManager();
  }
}
