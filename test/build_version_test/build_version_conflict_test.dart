import 'package:flutter_test/flutter_test.dart';
import 'package:game/version_checker.dart';

void main() {
  test('Build version conflict test', () async {
    final checker = VersionChecker();
    final result = await checker.checkVersion('1.0.0', '1.0.1');
    expect(result, false);
  });
}
