import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/constantes/limites_caracteres.dart';

void main() {
  test('Limites de caracteres para App Store', () {
    expect(LimitesCaracteres.appStoreTitulo, 30);
    expect(LimitesCaracteres.appStoreDescricaoCurta, 80);
    expect(LimitesCaracteres.appStoreDescricaoLonga, 4000);
  });

  test('Limites de caracteres para Play Store', () {
    expect(LimitesCaracteres.playStoreTitulo, 50);
    expect(LimitesCaracteres.playStoreDescricaoCurta, 80);
    expect(LimitesCaracteres.playStoreDescricaoLonga, 4000);
  });

  test('Limites de caracteres para Documentação Interna', () {
    expect(LimitesCaracteres.documentacaoInternaTitulo, 100);
    expect(LimitesCaracteres.documentacaoInternaDescricao, 10000);
  });
}
