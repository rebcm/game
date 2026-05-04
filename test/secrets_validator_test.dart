import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/secrets_validator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('SecretsValidator', () {
    test('should return true when SECRET_KEY is set', () async {
      await dotenv.load(fileName: '.env.example');
      final validator = SecretsValidator();
      final result = await validator.validateSecrets();
      expect(result, true);
    });

    test('should return false when SECRET_KEY is not set', () async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env['SECRET_KEY'] = '';
      final validator = SecretsValidator();
      final result = await validator.validateSecrets();
      expect(result, false);
    });
  });
}
