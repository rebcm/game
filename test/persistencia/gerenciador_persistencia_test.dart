import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/persistencia/gerenciador_persistencia.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('GerenciadorPersistencia', () {
    late GerenciadorPersistencia gerenciador;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      gerenciador = GerenciadorPersistencia();
      await gerenciador.inicializar();
    });

    test('inicializa SharedPreferences', () async {
      expect(gerenciador.carregarInventario(), isA<Map<String, dynamic>>());
    });

    test('salva e carrega inventário corretamente', () async {
      final inventario = {'bloco1': 10, 'bloco2': 5};
      await gerenciador.salvarInventario(inventario);
      final inventarioCarregado = gerenciador.carregarInventario();
      expect(inventarioCarregado, inventario);
    });

    test('salva e carrega posição da Rebeca corretamente', () async {
      final posicao = {'x': 1.0, 'y': 2.0, 'z': 3.0};
      await gerenciador.salvarPosicaoRebeca(posicao);
      final posicaoCarregada = gerenciador.carregarPosicaoRebeca();
      expect(posicaoCarregada, posicao);
    });
  });
}
