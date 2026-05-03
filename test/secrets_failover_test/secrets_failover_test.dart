import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

void main() {
  group('Secrets Failover Test', () {
    test('Build should fail when required secrets are missing', () async {
      await dotenv.load(fileName: '.env.example'); // Load example env without secrets
      expect(() => Process.runSync('flutter', ['build', 'apk']),
        throwsA(isA<ProcessException>()));
    });

    test('Build should fail when required secrets are incorrect', () async {
      await dotenv.load(fileName: '.env'); // Assuming .env has incorrect secrets
      expect(() => Process.runSync('flutter', ['build', 'apk']),
        throwsA(isA<ProcessException>()));
    });
  });
}
