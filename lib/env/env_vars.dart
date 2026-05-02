import 'package:flutter/foundation.dart';

class EnvVars {
  static const String var1 = String.fromEnvironment('VAR1');
  static const String var2 = String.fromEnvironment('VAR2');

  static bool get isValid {
    // Add validation logic here
    return true;
  }
}
