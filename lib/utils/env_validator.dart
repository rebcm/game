import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvValidator {
  static Future<void> validate() async {
    await dotenv.load();
    final requiredVars = [
      'API_KEY',
      'API_SECRET',
      'CLOUDFLARE_TOKEN',
    ];
    for (var variable in requiredVars) {
      if (dotenv.env[variable] == null || dotenv.env[variable]!.isEmpty) {
        throw Exception('$variable is missing or empty');
      }
    }
  }
}
