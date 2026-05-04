import 'package:flutter_test/flutter_test.dart';
import 'package:game/docs/documentacao.dart';

void main() {
  test('Documentacao.fromJson', () {
    final json = {'descricao': 'Descrição', 'categoria': 'Categoria'};
    final documentacao = Documentacao.fromJson(json);
    expect(documentacao.descricao, 'Descrição');
    expect(documentacao.categoria, 'Categoria');
  });
}
