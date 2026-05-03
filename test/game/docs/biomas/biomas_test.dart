import 'package:test/test.dart';
import 'package:game/docs/biomas/biomas.dart';

void main() {
  test('Bioma padrão deve ter nome e descrição', () {
    expect(Bioma.biomaPadrao.nome, isNotEmpty);
    expect(Bioma.biomaPadrao.descricao, isNotEmpty);
  });
}

