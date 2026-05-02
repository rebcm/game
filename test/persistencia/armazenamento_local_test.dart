import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/persistencia/armazenamento_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ArmazenamentoLocal', () {
    late ArmazenamentoLocal armazenamento;

    setUp(() {
      armazenamento = ArmazenamentoLocal();
      SharedPreferences.setMockInitialValues({});
    });

    test('salvar e carregar mundo', () async {
      const mundo = 'mundo_teste';
      await armazenamento.salvarMundo(mundo);
      final carregado = await armazenamento.carregarMundo();
      expect(carregado, mundo);
    });

    test('carregar mundo não existente', () async {
      final carregado = await armazenamento.carregarMundo();
      expect(carregado, isNull);
    });
  });
}
