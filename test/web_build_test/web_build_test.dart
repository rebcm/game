import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Flutter Web Build Test', () async {
    await Process.run('flutter', ['build', 'web', '--release']);
    expect(File('build/web/index.html').existsSync(), true);
  });
}
