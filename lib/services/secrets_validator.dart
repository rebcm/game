import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsValidator {
  Future<bool> validateSecrets() async {
    await dotenv.load();
    final secretKey = dotenv.env['SECRET_KEY'];
    return secretKey != null && secretKey.isNotEmpty;
  }
}
