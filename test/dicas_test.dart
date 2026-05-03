import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  test('Dicas strings extraction test', () {
    final dicas = Dicas();
    final strings = dicas.getAllDicasStrings();
    expect(strings, isNotEmpty);
  });
}
