import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/persistencia/gerenciador_preferencias.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('GerenciadorPreferencias', () {
    test('salvar e carregar mundo', () async {
      SharedPreferences.setMockInitialValues({});
      final gerenciador = GerenciadorPreferencias();
      final mundo = 'mundo_teste';

      await gerenciador.salvarMundo(mundo);
      final mundoCarregado = await gerenciador.carregarMundo();

      expect(mundoCarregado, mundo);
    });
  });
}
