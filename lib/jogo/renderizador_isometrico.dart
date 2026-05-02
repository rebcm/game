import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/jogo/renderizador_isometrico_otimizado.dart';

class RenderizadorIsometrico {
  final RenderizadorIsometricoOtimizado _otimizador;

  RenderizadorIsometrico() : _otimizador = RenderizadorIsometricoOtimizado();

  void renderizar(Canvas canvas, List<Chunk> chunks) {
    for (var chunk in chunks) {
      _otimizador.renderizarChunk(canvas, chunk);
    }
  }
}
