import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('Secrets Validation Test', () {
    test('should fail when signature secret is missing', () async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env.remove('SIGNATURE_SECRET');
      expect(() => dotenv.env['SIGNATURE_SECRET'], throwsAssertionError);
    });

    test('should fail when signature secret is malformed', () async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env['SIGNATURE_SECRET'] = 'invalid_secret';
      expect(() => dotenv.env['SIGNATURE_SECRET'], throwsAssertionError);
    });
  });
}
