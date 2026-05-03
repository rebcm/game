import 'package:flutter/foundation.dart';

class EnvironmentConfig {
  static String? databaseUrl = const String.fromEnvironment('DATABASE_URL');
  static String? apiKey = const String.fromEnvironment('API_KEY');
  // Add other config vars as needed

  static void init() {
    debugPrint('Database URL: \$databaseUrl');
    debugPrint('API Key: \$apiKey');
    // Add other debug prints as needed
  }
}
