import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/env_validator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('EnvValidator', () {
    test('validateEnv succeeds with all keys present', () async {
      await dotenv.load(fileName: '.env.example');
      await EnvValidator.validateEnv();
      // No exception expected
    });

    test('validateEnv throws with missing key', () async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env.remove('KEY1');
      expect(() async => await EnvValidator.validateEnv(), throwsException);
    });
  });
}
