import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/utils/frustum_culling.dart';

class RenderizadorIsometrico extends StatefulWidget {
  @override
  _RenderizadorIsometricoState createState() => _RenderizadorIsometricoState();
}

class _RenderizadorIsometricoState extends State<RenderizadorIsometrico> {
  late Frustum _frustum;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _frustum = Frustum(
      context.size!.width,
      context.size!.height,
      GeradorMundo.tamanhoChunk * TipoBloco.values.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _IsometricPainter(_frustum),
    );
  }
}

class _IsometricPainter extends CustomPainter {
  final Frustum _frustum;

  _IsometricPainter(this._frustum);

  @override
  void paint(Canvas canvas, Size size) {
    // Implementação existente do renderizador isométrico
    // com a adição do culling usando _frustum
    for (var chunk in GeradorMundo.chunks) {
      for (var bloco in chunk.blocos) {
        if (_frustum.isVisible(bloco.posicao.x, bloco.posicao.y, bloco.posicao.z)) {
          // Renderiza o bloco
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
