import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/version_utils.dart';

void main() {
  test('deve validar versão do Flutter corretamente', () {
    expect(VersionUtils.isValidFlutterVersion('3.0.0'), true);
    expect(VersionUtils.isValidFlutterVersion('2.0.0'), false);
  });

  test('deve validar versão do Dart corretamente', () {
    expect(VersionUtils.isValidDartVersion('2.17.0'), true);
    expect(VersionUtils.isValidDartVersion('2.16.0'), false);
  });
}
