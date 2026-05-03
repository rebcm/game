import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ConstrucaoCriativaApp());
}

class ConstrucaoCriativaApp extends StatelessWidget {
  const ConstrucaoCriativaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa da Rebeca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MenuPrincipal(),
    );
  }
}

// Tipos de blocos
enum TipoBloco {
  vazio,
  grama,
  terra,
  areia,
  pedra,
  madeira,
  folha,
  agua,
  fogo,
  ouro,
  diamante,
}

extension TipoBlocoExt on TipoBloco {
  String get nome {
    switch (this) {
      case TipoBloco.vazio: return 'Vazio';
      case TipoBloco.grama: return 'Grama';
      case TipoBloco.terra: return 'Terra';
      case TipoBloco.areia: return 'Areia';
      case TipoBloco.pedra: return 'Pedra';
      case TipoBloco.madeira: return 'Madeira';
      case TipoBloco.folha: return 'Folha';
      case TipoBloco.agua: return 'Agua';
      case TipoBloco.fogo: return 'Fogo';
      case TipoBloco.ouro: return 'Ouro';
      case TipoBloco.diamante: return 'Diamante';
    }
  }

  Color get corTopo {
    switch (this) {
      case TipoBloco.vazio: return Colors.transparent;
      case TipoBloco.grama: return const Color(0xFF4CAF50);
      case TipoBloco.terra: return const Color(0xFF8D6E63);
      case TipoBloco.areia: return const Color(0xFFFFEB3B);
      case TipoBloco.pedra: return const Color(0xFF9E9E9E);
      case TipoBloco.madeira: return const Color(0xFF795548);
      case TipoBloco.folha: return const Color(0xFF2E7D32);
      case TipoBloco.agua: return const Color(0xFF2196F3);
      case TipoBloco.fogo: return const Color(0xFFFF5722);
      case TipoBloco.ouro: return const Color(0xFFFFD700);
      case TipoBloco.diamante: return const Color(0xFF00BCD4);
    }
  }

  Color get corLado {
    return Color.fromARGB(
      corTopo.alpha,
      (corTopo.red * 0.7).round(),
      (corTopo.green * 0.7).round(),
      (corTopo.blue * 0.7).round(),
    );
  }

  Color get corFrente {
    return Color.fromARGB(
      corTopo.alpha,
      (corTopo.red * 0.85).round(),
      (corTopo.green * 0.85).round(),
      (corTopo.blue * 0.85).round(),
    );
  }
}

// Menu Principal
class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1565C0), Color(0xFF4CAF50)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '\u{1F3D7}',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 16),
              const Text(
                'Construcao Criativa',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
              const Text(
                'da Rebeca',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.yellowAccent,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const TelaJogo()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Jogar'),
              ),
              const SizedBox(height: 24),
              const Text(
                'por Rebeca Alves Moreira',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela principal do jogo
class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  static const int tamanhoMundo = 24;
  late List<List<TipoBloco>> mundo;
  TipoBloco blocoSelecionado = TipoBloco.grama;
  final List<TipoBloco> inventario = [
    TipoBloco.grama,
    TipoBloco.terra,
    TipoBloco.areia,
    TipoBloco.pedra,
    TipoBloco.madeira,
    TipoBloco.folha,
    TipoBloco.agua,
    TipoBloco.fogo,
    TipoBloco.ouro,
    TipoBloco.diamante,
  ];

  Offset _cameraOffset = const Offset(0, 0);
  Offset? _dragStart;
  Offset? _dragStartCamera;
  bool _pausado = false;

  @override
  void initState() {
    super.initState();
    _initMundo();
    _carregarMundo();
  }

  void _initMundo() {
    final rng = Random(42);
    mundo = List.generate(tamanhoMundo, (x) =>
      List.generate(tamanhoMundo, (z) {
        final r = rng.nextDouble();
        if (r < 0.5) return TipoBloco.grama;
        if (r < 0.65) return TipoBloco.terra;
        if (r < 0.75) return TipoBloco.areia;
        if (r < 0.82) return TipoBloco.pedra;
        if (r < 0.88) return TipoBloco.madeira;
        if (r < 0.93) return TipoBloco.agua;
        return TipoBloco.folha;
      })
    );
  }

  Future<void> _carregarMundo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dados = prefs.getString('mundo_rebeca');
      if (dados != null) {
        final valores = dados.split(',');
        if (valores.length == tamanhoMundo * tamanhoMundo) {
          setState(() {
            for (int x = 0; x < tamanhoMundo; x++) {
              for (int z = 0; z < tamanhoMundo; z++) {
                final idx = int.tryParse(valores[x * tamanhoMundo + z]) ?? 0;
                if (idx >= 0 && idx < TipoBloco.values.length) {
                  mundo[x][z] = TipoBloco.values[idx];
                }
              }
            }
          });
        }
      }
    } catch (_) {}
  }

  Future<void> _salvarMundo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final buffer = StringBuffer();
      for (int x = 0; x < tamanhoMundo; x++) {
        for (int z = 0; z < tamanhoMundo; z++) {
          if (x > 0 || z > 0) buffer.write(',');
          buffer.write(mundo[x][z].index);
        }
      }
      await prefs.setString('mundo_rebeca', buffer.toString());
    } catch (_) {}
  }

  void _onTapBloco(int x, int z) {
    setState(() {
      if (mundo[x][z] == blocoSelecionado) {
        mundo[x][z] = TipoBloco.vazio;
      } else {
        mundo[x][z] = blocoSelecionado;
      }
    });
    _salvarMundo();
  }

  (int, int)? _screenToBlock(Offset pos, Size size, double tileW, double tileH) {
    final cx = size.width / 2 + _cameraOffset.dx;
    final cy = size.height / 3 + _cameraOffset.dy;
    final dx = pos.dx - cx;
    final dy = pos.dy - cy;
    final x = (dx / (tileW / 2) + dy / (tileH / 2)) / 2;
    final z = (dy / (tileH / 2) - dx / (tileW / 2)) / 2;
    final xi = x.round();
    final zi = z.round();
    if (xi >= 0 && xi < tamanhoMundo && zi >= 0 && zi < tamanhoMundo) {
      return (xi, zi);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
            setState(() => _pausado = !_pausado);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6)],
                ),
              ),
            ),
            GestureDetector(
              onPanStart: (d) {
                _dragStart = d.localPosition;
                _dragStartCamera = _cameraOffset;
              },
              onPanUpdate: (d) {
                setState(() {
                  _cameraOffset = _dragStartCamera! + (d.localPosition - _dragStart!);
                });
              },
              onTapUp: (d) {
                final size = context.size ?? const Size(800, 600);
                const tileW = 48.0;
                const tileH = 24.0;
                final coord = _screenToBlock(d.localPosition, size, tileW, tileH);
                if (coord != null) {
                  _onTapBloco(coord.$1, coord.$2);
                }
              },
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: MundoPainter(
                      mundo: mundo,
                      tamanho: tamanhoMundo,
                      cameraOffset: _cameraOffset,
                    ),
                  );
                },
              ),
            ),
            // HUD Superior
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Text('Rebeca', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Text('Construcao Criativa', style: TextStyle(color: Colors.yellowAccent, fontSize: 14)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.pause, color: Colors.white),
                      onPressed: () => setState(() => _pausado = true),
                      tooltip: 'Pausar (ESC)',
                    ),
                  ],
                ),
              ),
            ),
            // HUD Inferior - Inventário
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Bloco: ${blocoSelecionado.nome}',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: inventario.map((bloco) {
                          final selecionado = bloco == blocoSelecionado;
                          return GestureDetector(
                            onTap: () => setState(() => blocoSelecionado = bloco),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: bloco.corTopo,
                                border: Border.all(
                                  color: selecionado ? Colors.yellow : Colors.white54,
                                  width: selecionado ? 3 : 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  bloco.nome.substring(0, min(3, bloco.nome.length)),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Toque para colocar/remover - Arraste para mover a camera - ESC para pausar',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            // Tela de pausa
            if (_pausado)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Pausado', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => setState(() => _pausado = false),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('Continuar', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const MenuPrincipal()),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Menu Principal', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter para renderizar o mundo isométrico
class MundoPainter extends CustomPainter {
  final List<List<TipoBloco>> mundo;
  final int tamanho;
  final Offset cameraOffset;
  static const double tileW = 48.0;
  static const double tileH = 24.0;
  static const double tileD = 16.0;

  const MundoPainter({
    required this.mundo,
    required this.tamanho,
    required this.cameraOffset,
  });

  Offset _isoPos(int x, int z, Size size) {
    final cx = size.width / 2 + cameraOffset.dx;
    final cy = size.height / 3 + cameraOffset.dy;
    return Offset(
      cx + (x - z) * tileW / 2,
      cy + (x + z) * tileH / 2,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int x = 0; x < tamanho; x++) {
      for (int z = 0; z < tamanho; z++) {
        final bloco = mundo[x][z];
        if (bloco == TipoBloco.vazio) continue;
        _drawBloco(canvas, x, z, bloco, size);
      }
    }
    _drawRebeca(canvas, tamanho ~/ 2, tamanho ~/ 2, size);
  }

  void _drawBloco(Canvas canvas, int x, int z, TipoBloco bloco, Size size) {
    final pos = _isoPos(x, z, size);
    final cx = pos.dx;
    final cy = pos.dy;

    final topPath = Path()
      ..moveTo(cx, cy - tileD)
      ..lineTo(cx + tileW / 2, cy - tileD + tileH / 2)
      ..lineTo(cx, cy - tileD + tileH)
      ..lineTo(cx - tileW / 2, cy - tileD + tileH / 2)
      ..close();

    final rightPath = Path()
      ..moveTo(cx + tileW / 2, cy - tileD + tileH / 2)
      ..lineTo(cx + tileW / 2, cy + tileH / 2)
      ..lineTo(cx, cy + tileH)
      ..lineTo(cx, cy - tileD + tileH)
      ..close();

    final leftPath = Path()
      ..moveTo(cx - tileW / 2, cy - tileD + tileH / 2)
      ..lineTo(cx, cy - tileD + tileH)
      ..lineTo(cx, cy + tileH)
      ..lineTo(cx - tileW / 2, cy + tileH / 2)
      ..close();

    final paintTop = Paint()..color = bloco.corTopo;
    final paintRight = Paint()..color = bloco.corFrente;
    final paintLeft = Paint()..color = bloco.corLado;
    final paintBorder = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    canvas.drawPath(topPath, paintTop);
    canvas.drawPath(topPath, paintBorder);
    canvas.drawPath(rightPath, paintRight);
    canvas.drawPath(rightPath, paintBorder);
    canvas.drawPath(leftPath, paintLeft);
    canvas.drawPath(leftPath, paintBorder);

    if (bloco == TipoBloco.agua) {
      final paintAlpha = Paint()..color = Colors.blue.withOpacity(0.3);
      canvas.drawPath(topPath, paintAlpha);
    }
  }

  void _drawRebeca(Canvas canvas, int x, int z, Size size) {
    final pos = _isoPos(x, z, size);
    final cx = pos.dx;
    final cy = pos.dy - tileD;

    final paintRosto = Paint()..color = const Color(0xFFFFDBAC);
    final paintCabelo = Paint()..color = const Color(0xFFFFD700);
    final paintRoupa = Paint()..color = const Color(0xFF9C27B0);
    final paintCalca = Paint()..color = const Color(0xFF3F51B5);
    final paintBorda = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Rect.fromLTWH(cx - 6, cy - 28, 12, 12), paintRosto);
    canvas.drawRect(Rect.fromLTWH(cx - 6, cy - 28, 12, 12), paintBorda);
    canvas.drawRect(Rect.fromLTWH(cx - 7, cy - 30, 14, 6), paintCabelo);
    canvas.drawRect(Rect.fromLTWH(cx - 7, cy - 30, 14, 6), paintBorda);
    canvas.drawRect(Rect.fromLTWH(cx - 5, cy - 16, 10, 12), paintRoupa);
    canvas.drawRect(Rect.fromLTWH(cx - 5, cy - 16, 10, 12), paintBorda);
    canvas.drawRect(Rect.fromLTWH(cx - 5, cy - 4, 4, 8), paintCalca);
    canvas.drawRect(Rect.fromLTWH(cx + 1, cy - 4, 4, 8), paintCalca);
    canvas.drawRect(Rect.fromLTWH(cx - 5, cy - 4, 10, 8), paintBorda);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Rebeca',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(cx - textPainter.width / 2, cy - 38));
  }

  @override
  bool shouldRepaint(MundoPainter old) =>
    old.mundo != mundo || old.cameraOffset != cameraOffset;
}
