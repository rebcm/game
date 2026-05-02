import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rebcm/servicos/persistencia.dart';

void main() {
  group('ServicoPersistencia', () {
    late ServicoPersistencia servico;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      servico = ServicoPersistencia();
    });

    test('salva e carrega mundo corretamente', () async {
      const mundo = 'dados-do-mundo';
      await servico.salvarMundo(mundo);
      final carregado = await servico.carregarMundo();
      expect(carregado, mundo);
    });

    test('retorna null quando não há dados salvos', () async {
      final carregado = await servico.carregarMundo();
      expect(carregado, isNull);
    });
  });
}
