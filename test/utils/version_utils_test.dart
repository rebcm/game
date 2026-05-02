import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/version_utils.dart';

void main() {
  test('checkFlutterVersion should pass for correct version', () {
    // Simula a versão correta
    expect(VersionUtils.flutterVersionString(), startsWith('Flutter 3.0.'));
  });

  test('checkDartVersion should pass for correct version', () {
    // Simula a versão correta
    expect(VersionUtils.dartVersionString(), startsWith('Dart 2.17.'));
  });
}
