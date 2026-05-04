import 'package:flutter/foundation.dart';

class EnvConfig {
  static const String author = 'Rebeca Alves Moreira';
  static const String environment = String.fromEnvironment('ENVIRONMENT');
  static const bool isPreview = environment == 'preview';

  static void init() {
    debugPrint('Environment: $environment');
    debugPrint('Is Preview: $isPreview');
  }
}
