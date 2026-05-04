import 'package:flutter/foundation.dart';

enum Environment { staging, production }

class EnvironmentConfig {
  static Environment? _environment;

  static void init({required Environment environment}) {
    _environment = environment;
  }

  static Environment get environment {
    if (_environment == null) {
      throw Exception('Environment not initialized');
    }
    return _environment!;
  }

  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.production;
}
