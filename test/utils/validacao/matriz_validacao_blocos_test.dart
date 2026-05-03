import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/validacao/matriz_validacao_blocos.dart';

void main() {
  test('validarBlocos deve retornar true quando todos os blocos implementados têm descrições', () {
    // Arrange
    MatrizValidacaoBlocos.blocosImplementados.forEach((bloco) {
      MatrizValidacaoBlocos.descricaoBlocos[bloco] = 'Descrição do $bloco';
    });

    // Act
    final resultado = MatrizValidacaoBlocos.validarBlocos();

    // Assert
    expect(resultado, true);
  });

  test('validarBlocos deve retornar false quando algum bloco implementado não tem descrição', () {
    // Arrange
    MatrizValidacaoBlocos.blocosImplementados.add('blocoSemDescricao');

    // Act
    final resultado = MatrizValidacaoBlocos.validarBlocos();

    // Assert
    expect(resultado, false);
  });
}
