import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/dicas.dart';

void main() {
  test('dicas obrigatórias estão presentes', () {
    final dicas = Dicas.obrigatorias;
    expect(dicas, isNotEmpty);
  });

  test('dicas estão no formato correto', () {
    final dicas = Dicas.obrigatorias;
    for (var dica in dicas) {
      expect(dica, contains(':'));
    }
  });
}
