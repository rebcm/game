import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/docs/diagrama_fluxo_requisicoes.dart';

void main() {
  test('deve retornar o diagrama de fluxo de requisições', () {
    final diagrama = DiagramaFluxoRequisicoes();
    expect(diagrama.getDiagrama(), isNotEmpty);
  });
}
