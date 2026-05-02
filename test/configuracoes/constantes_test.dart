import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/configuracoes/constantes.dart';

void main() {
  test('Constantes.autor deve ser Rebeca Alves Moreira', () {
    expect(Constantes.autor, 'Rebeca Alves Moreira');
  });

  test('Constantes.palavrasChaveSEO deve conter palavras-chave relevantes', () {
    expect(Constantes.palavrasChaveSEO, isNotEmpty);
    expect(Constantes.palavrasChaveSEO, contains('Flutter'));
    expect(Constantes.palavrasChaveSEO, contains('Voxel'));
    expect(Constantes.palavrasChaveSEO, contains('PassDriver'));
  });
}
