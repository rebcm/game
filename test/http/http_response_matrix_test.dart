import 'package:flutter_test/flutter_test.dart';
import 'package:game/http/http_response_matrix.dart';

void main() {
  test('Verifica se a matriz de respostas HTTP está correta', () {
    expect(HttpResponseMatrix.responseMatrix, isNotNull);
    expect(HttpResponseMatrix.responseMatrix['/api/exemplo'], isNotNull);
    expect(HttpResponseMatrix.responseMatrix['/api/exemplo'][200], '{ "mensagem": "Sucesso" }');
    expect(HttpResponseMatrix.responseMatrix['/api/exemplo'][400], '{ "erro": "Requisição inválida" }');
    expect(HttpResponseMatrix.responseMatrix['/api/exemplo'][401], '{ "erro": "Não autorizado" }');
    expect(HttpResponseMatrix.responseMatrix['/api/exemplo'][500], '{ "erro": "Erro interno do servidor" }');
  });
}
