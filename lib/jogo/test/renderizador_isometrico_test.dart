import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  test('RenderizadorIsometrico renders a block', () {
    final renderizador = RenderizadorIsometrico();
    expect(renderizador.renderBloco(TipoBloco.grama), isNotNull);
  });
}
