import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsService {
  static String? get keystore => dotenv.env['KEYSTORE'];
  static String? get keystorePassword => dotenv.env['KEYSTORE_PASSWORD'];
  static String? get keyAlias => dotenv.env['KEY_ALIAS'];
  static String? get keyPassword => dotenv.env['KEY_PASSWORD'];

  static Future<void> init() async {
    await dotenv.load();
  }
}
