import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/bloco_referencia.dart';

void main() {
  test('Testa se a lista de blocos não está vazia', () {
    List<String> blocos = BlocoReferencia.getBlocos();
    expect(blocos, isNotEmpty);
  });

  test('Testa se a lista de blocos contém "grama"', () {
    List<String> blocos = BlocoReferencia.getBlocos();
    expect(blocos.contains('grama'), true);
  });
}
