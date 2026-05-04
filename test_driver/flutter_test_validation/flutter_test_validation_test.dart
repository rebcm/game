import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Verifica se o comando flutter test foi executado com sucesso', () {
    final result = Process.runSync('dart', ['test_driver/flutter_test_validation/flutter_test_validation.dart']);
    expect(result.exitCode, 0);
  });
}
