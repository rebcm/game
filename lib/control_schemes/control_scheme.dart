import 'package:flutter/services.dart';

abstract class ControlScheme {
  void handleKeyEvent(RawKeyEvent event);
}
