import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'dart:io';

void main() {
  test('Flutter version should be at least 3.0.0', () async {
    final result = await Process.run('flutter', ['--version']);
    final output = result.stdout.toString();
    expect(output.contains('Flutter 3.0.0'), isTrue);
  });

  test('Java version should be 17', () async {
    final result = await Process.run('java', ['-version']);
    final output = result.stderr.toString();
    expect(output.contains('openjdk version "17'), isTrue);
  });
}
