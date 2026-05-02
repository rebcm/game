import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String get apiUrl {
    if (dotenv.env['ENV'] == 'production') {
      return dotenv.env['PRODUCTION_API_URL'] ?? '';
    } else if (dotenv.env['ENV'] == 'staging') {
      return dotenv.env['STAGING_API_URL'] ?? '';
    } else {
      throw Exception('Invalid environment');
    }
  }
}
