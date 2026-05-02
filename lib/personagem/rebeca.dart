import Intl.message('package:flutter/material.dart');
import Intl.message('../blocos/tipo_bloco.dart');
import Intl.message('../mundo/posicao3d.dart');

enum DirecaoOlhar { norte, sul, leste, oeste }

class Rebeca extends ChangeNotifier {
  double x;
  double y;
  double z;
  double velocidadeX = 0;
  double velocidadeZ = 0;
  DirecaoOlhar direcao = DirecaoOlhar.sul;

  // Inventário criativo — acesso a todos os blocos
  final List<TipoBloco> inventario = [
    TipoBloco.grama,
    TipoBloco.terra,
    TipoBloco.pedra,
    TipoBloco.madeira,
    TipoBloco.tijolos,
    TipoBloco.vidro,
    TipoBloco.ouro,
    TipoBloco.diamante,
    TipoBloco.luz,
  ];

  int slotselecionado = 0;
  TipoBloco get blocoSelecionado => inventario[slotselecionado];

  Rebeca({this.x = 8.0, this.y = 20.0, this.z = 8.0});

  Posicao3D get posicaoBloco =>
      Posicao3D(x.floor(), y.floor(), z.floor());

  void moverPara(double nx, double ny, double nz) {
    x = nx;
    y = ny;
    z = nz;
    notifyListeners();
  }

  void selecionarSlot(int slot) {
    if (slot >= 0 && slot < inventario.length) {
      slotselecionado = slot;
      notifyListeners();
    }
  }

  void virarPara(DirecaoOlhar dir) {
    direcao = dir;
    notifyListeners();
  }

  Posicao3D get blocoDaFrente {
    switch (direcao) {
      case DirecaoOlhar.norte: return Posicao3D(x.floor(), y.floor(), (z - 1).floor());
      case DirecaoOlhar.sul: return Posicao3D(x.floor(), y.floor(), (z + 1).floor());
      case DirecaoOlhar.leste: return Posicao3D((x + 1).floor(), y.floor(), z.floor());
      case DirecaoOlhar.oeste: return Posicao3D((x - 1).floor(), y.floor(), z.floor());
    }
  }

  void pintar(Canvas canvas, Offset centro) {
    _desenharCorpo(canvas, centro);
    _desenharCabeca(canvas, centro);
    _desenharNome(canvas, centro);
  }

  void _desenharCorpo(Canvas canvas, Offset centro) {
    final paint = Paint();

    // Vestido rosa
    paint.color = const Color(0xFFE91E63);
    canvas.drawRect(
      Rect.fromCenter(center: centro + const Offset(0, 8), width: 20, height: 24),
      paint,
    );

    // Braços
    paint.color = const Color(0xFFFDBCB4);
    canvas.drawRect(
      Rect.fromCenter(center: centro + const Offset(-13, 4), width: 8, height: 18),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: centro + const Offset(13, 4), width: 8, height: 18),
      paint,
    );

    // Pernas
    paint.color = const Color(0xFF1565C0);
    canvas.drawRect(
      Rect.fromCenter(center: centro + const Offset(-5, 22), width: 8, height: 16),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: centro + const Offset(5, 22), width: 8, height: 16),
      paint,
    );
  }

  void _desenharCabeca(Canvas canvas, Offset centro) {
    final paint = Paint();
    final topoCabeca = centro + const Offset(0, -16);

    // Rosto
    paint.color = const Color(0xFFFDBCB4);
    canvas.drawRect(
      Rect.fromCenter(center: topoCabeca, width: 24, height: 24),
      paint,
    );

    // Cabelo loiro
    paint.color = const Color(0xFFFFD700);
    canvas.drawRect(
      Rect.fromCenter(center: topoCabeca + const Offset(0, -10), width: 26, height: 8),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: topoCabeca + const Offset(-14, -4), width: 6, height: 16),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: topoCabeca + const Offset(14, -4), width: 6, height: 16),
      paint,
    );

    // Olhos
    paint.color = const Color(0xFF1976D2);
    canvas.drawCircle(topoCabeca + const Offset(-5, -2), 3, paint);
    canvas.drawCircle(topoCabeca + const Offset(5, -2), 3, paint);

    // Boca sorrindo
    paint.color = const Color(0xFFE91E63);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawArc(
      Rect.fromCenter(center: topoCabeca + const Offset(0, 4), width: 10, height: 6),
      0, 3.14, false, paint,
    );
    paint.style = PaintingStyle.fill;
  }

  void _desenharNome(Canvas canvas, Offset centro) {
    final textPainter = TextPainter(
      text: const TextSpan(
        text: Intl.message('Rebeca'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      centro + Offset(-textPainter.width / 2, -46),
    );
  }
}
