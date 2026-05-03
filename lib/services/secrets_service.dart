import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsService {
  static String? get keystorePath => dotenv.env['KEYSTORE_PATH'];
  static String? get certificatePath => dotenv.env['CERTIFICATE_PATH'];

  static bool validateKeystores() {
    if (keystorePath == null || certificatePath == null) {
      return false;
    }

    // Implementar lógica de validação adicional aqui, se necessário
    return true;
  }
}
