import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  test('Verifica versão do Flutter e Dart', () {
    expect(FlutterVersion.major, 3);
    expect(FlutterVersion.minor, greaterThanOrEqualTo(0));
    expect(DartVersion.major, 2);
    expect(DartVersion.minor, greaterThanOrEqualTo(17));
  });
}
