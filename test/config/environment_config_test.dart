import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/environment_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('EnvironmentConfig', () {
    test('should return production API URL when ENV is production', () async {
      await dotenv.load(fileName: '.env');
      dotenv.env['ENV'] = 'production';
      expect(EnvironmentConfig.apiUrl, 'https://api.rebcm.game');
    });

    test('should return staging API URL when ENV is staging', () async {
      await dotenv.load(fileName: '.env');
      dotenv.env['ENV'] = 'staging';
      expect(EnvironmentConfig.apiUrl, 'https://staging-api.rebcm.game');
    });

    test('should throw exception when ENV is invalid', () async {
      await dotenv.load(fileName: '.env');
      dotenv.env['ENV'] = 'invalid';
      expect(() => EnvironmentConfig.apiUrl, throwsException);
    });
  });
}
