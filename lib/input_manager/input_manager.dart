import 'package:flutter/services.dart';
import 'input_command.dart';

abstract class InputManager {
  void handleKeyEvent(RawKeyEvent event);
  bool isCommandPressed(InputCommand command);
  void update();
}
