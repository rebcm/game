import 'package:test/test.dart';
import 'package:rebcm/utils/analisador_qualidade.dart';

void main() {
  test('AnalisadorQualidade analisarQualidade', () {
    List<int> dadosOriginais = [1, 2, 3, 4, 5];
    List<int> dadosComprimidos = [1, 2, 3, 4, 5]; // Exemplo sem perda
    double qualidade = AnalisadorQualidade.analisarQualidade(dadosOriginais, dadosComprimidos);
    expect(qualidade, 0); // Perda zero
  });
}
