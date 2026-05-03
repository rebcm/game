import 'package:flutter/foundation.dart';

class Secrets {
  static String? get dbConnectionString => const String.fromEnvironment('DB_CONNECTION_STRING');
  static String? get apiKey => const String.fromEnvironment('API_KEY');
}
