import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('Environment Variables Validation', () {
    test('should load .env file', () async {
      await dotenv.load();
      expect(dotenv.env, isNotNull);
    });

    test('should validate required environment variables', () async {
      await dotenv.load();
      final requiredVars = [
        'API_KEY',
        'API_SECRET',
        'CLOUDFLARE_TOKEN',
      ];
      for (var variable in requiredVars) {
        expect(dotenv.env[variable], isNotNull, reason: '$variable is missing');
        expect(dotenv.env[variable], isNotEmpty, reason: '$variable is empty');
      }
    });
  });
}
