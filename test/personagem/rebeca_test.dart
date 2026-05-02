import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  test('atualizar chama estaSincronizada', () {
    Rebeca rebeca = Rebeca();
    rebeca.atualizar(60, 1);
    // Verificar se o método foi chamado
  });
}
