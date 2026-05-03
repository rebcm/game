import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  group('Signing Secrets Fail-Safe Test', () {
    test('should fail when signing secret is missing', () async {
      await dotenv.load(fileName: '.env.example');
      expect(() => dotenv.env['SIGNING_SECRET'], throwsA(isA<Error>()));
    });

    test('should fail when signing secret is malformed', () async {
      await dotenv.load(fileName: '.env.malformed');
      expect(() => dotenv.env['SIGNING_SECRET'], throwsA(isA<Error>()));
    });
  });
}
