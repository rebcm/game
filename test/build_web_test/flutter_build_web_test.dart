import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  test('Flutter build web should generate artifacts in the expected directory', () async {
    final result = await Process.run('flutter', ['build', 'web']);
    expect(result.exitCode, 0);
    expect(Directory('build/web').existsSync(), true);
  });
}
