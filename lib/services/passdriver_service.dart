import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game/utils/keystore_decoder.dart';

class PassdriverService {
  static Future<void> decodeSecrets() async {
    final String? keystoreBase64 = dotenv.env['KEYSTORE_BASE64'];
    final String? p12CertificateBase64 = dotenv.env['P12_CERTIFICATE_BASE64'];

    if (keystoreBase64 != null && p12CertificateBase64 != null) {
      await KeystoreDecoder.decodeKeystore(keystoreBase64, 'keystore.jks');
      await KeystoreDecoder.decodeP12Certificate(p12CertificateBase64, 'certificate.p12');
    }
  }
}
