import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/secrets_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('SecretsService', () {
    test('validateKeystores should return false if keystorePath is null', () async {
      await dotenv.load(fileName: '.env.example');
      expect(SecretsService.validateKeystores(), false);
    });

    test('validateKeystores should return true if keystorePath and certificatePath are valid', () async {
      await dotenv.load(fileName: '.env');
      expect(SecretsService.validateKeystores(), true);
    });
  });
}
