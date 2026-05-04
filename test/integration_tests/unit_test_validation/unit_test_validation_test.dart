import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart' as test_package;
import 'dart:io';

void main() {
  test_package.group('Unit Test Validation', () {
    test_package.test('should pass unit tests with exit code 0', () async {
      final result = await Process.run('flutter', ['test']);
      expect(result.exitCode, 0);
    });

    test_package.test('should report correct test summary', () async {
      final result = await Process.run('flutter', ['test', '--machine']);
      final output = result.stdout.toString();
      expect(output, contains('success'));
      expect(output, isNot(contains('failures')));
    });
  });
}
