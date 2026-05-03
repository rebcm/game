import 'package:test/test.dart';
import 'package:game/dicas.dart';

void main() {
  test('Dicas should return valid content', () {
    final dicas = Dicas().getDicas();
    expect(dicas, isNotEmpty);
  });

  test('Estruturas Sugeridas should return valid content', () {
    final estruturas = EstruturasSugeridas().getEstruturas();
    expect(estruturas, isNotEmpty);
  });
}
