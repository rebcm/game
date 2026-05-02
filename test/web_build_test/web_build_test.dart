import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Flutter Web build test', () async {
    await Process.run('flutter', ['config', '--enable-web']);
    final result = await Process.run('flutter', ['build', 'web', '--release']);
    expect(result.exitCode, 0);
  });
}
