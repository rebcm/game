import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvValidator {
  static Future<void> validateEnv() async {
    await dotenv.load();
    final requiredKeys = [
      'KEY1', // Replace with actual required keys from .env.example
      'KEY2',
    ];
    for (final key in requiredKeys) {
      if (!dotenv.env.containsKey(key)) {
        throw Exception('Missing required environment variable: $key');
      }
    }
  }
}
