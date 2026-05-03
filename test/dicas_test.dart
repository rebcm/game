import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  test('Testa se as dicas estão sendo extraídas corretamente', () {
    final dicas = Dicas();
    final strings = dicas.getAllStrings();
    expect(strings, isNotEmpty);
  });
}
