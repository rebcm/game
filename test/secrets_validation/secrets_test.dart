import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  group('Secrets Validation', () {
    test('should load .env file', () {
      expect(() => DotEnv(includePath: true).load(), returnsNormally);
    });

    test('should have SECRET_KEY configured', () {
      final env = DotEnv(includePath: true)..load();
      expect(env['SECRET_KEY'], isNotEmpty);
    });
  });
}
