import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> loadEnv() async {
    await dotenv.load();
  }

  static String? get(String key) {
    return dotenv.env[key];
  }
}
