import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvValidator {
  static const List<String> _requiredKeys = [
    'KEY1',
    'KEY2',
    // Add other required keys here as per .env.example
  ];

  static Future<void> validateEnv() async {
    await dotenv.load();
    for (var key in _requiredKeys) {
      if (!dotenv.env.containsKey(key)) {
        throw Exception('Missing required environment variable: $key');
      }
    }
  }
}
