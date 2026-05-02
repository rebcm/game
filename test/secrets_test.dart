import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:dotenv/dotenv.dart';

void main() {
  group('Secrets Test', () {
    test('All secrets missing', () async {
      // Simulate all secrets missing
      env = DotEnv();
      await app.main();
      // Verify error message for all secrets missing
    });

    test('Secrets partially missing', () async {
      // Simulate some secrets missing
      env = DotEnv();
      await app.main();
      // Verify error message for secrets partially missing
    });

    test('All secrets present', () async {
      // Simulate all secrets present
      env = DotEnv();
      await app.main();
      // Verify no error message when all secrets are present
    });
  });
}
