import 'package:flutter/services.dart' show rootBundle;
import 'package:dotenv/dotenv.dart' as dotenv;

class EnvLoader {
  static Future<dotenv.DotEnv> loadEnv() async {
    final envString = await rootBundle.loadString('.env');
    return dotenv.DotEnv.parse(envString);
  }
}
