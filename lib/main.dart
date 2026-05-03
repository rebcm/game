
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const ConstrucaoCriativaApp());
}

class ConstrucaoCriativaApp extends StatelessWidget {
  const ConstrucaoCriativaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Construcao Criativa da Rebeca',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Roboto'),
    home: const MenuPrincipal(),
  );
}

enum TipoBloco { vazio, grama, terra, areia, pedra, madeira, folha, agua, fogo, ouro, diamante, vidro, neve }

const kBlocoNomes = ['', 'Grama', 'Terra', 'Areia', 'Pedra', 'Madeira', 'Folha', 'Agua', 'Fogo', 'Ouro', 'Diamante', 'Vidro', 'Neve'];
const kBlocoCores = [Colors.transparent, Color(0xFF4CAF50), Color(0xFF8D6E63), Color(0xFFFFEB3B), Color(0xFF9E9E9E), Color(0xFF795548), Color(0xFF2E7D32), Color(0xFF1565C0), Color(0xFFFF5722), Color(0xFFFFD700), Color(0xFF00BCD4), Color(0xFFB3E5FC), Color(0xFFECEFF1)];
const kBlocoLateral = [Colors.transparent, Color(0xFF388E3C), Color(0xFF6D4C41), Color(0xFFFDD835), Color(0xFF757575), Color(0xFF4E342E), Color(0xFF1B5E20), Color(0xFF0D47A1), Color(0xFFE64A19), Color(0xFFFF8F00), Color(0xFF006064), Color(0xFF81D4FA), Color(0xFFCFD8DC)];
const kBlocoSombra = [Colors.transparent, Color(0xFF2E7D32), Color(0xFF4E342E), Color(0xFFF9A825), Color(0xFF424242), Color(0xFF3E2723), Color(0xFF1B5E20), Color(0xFF0D47A1), Color(0xFFBF360C), Color(0xFFE65100), Color(0xFF004D40), Color(0xFF4FC3F7), Color(0xFFB0BEC5)];

const int kMundoSize = 20;

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});
  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> with TickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D47A1), Color(0xFF1B5E20), Color(0xFF0D47A1)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _glow,
              builder: (_, __) => Text(
                'Construcao Criativa',
                style: TextStyle(
                  fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white,
                  shadows: [Shadow(color: Color.lerp(const Color(0xFF4CAF50), const Color(0xFFFFD700), _glow.value)!, blurRadius: 20)],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('da Rebeca', style: TextStyle(fontSize: 24, color: Color(0xFFFFD700), fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            const Text('Modo Criativo Voxel', style: TextStyle(fontSize: 16, color: Color(0xFFA5D6A7))),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaJogo())),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 8,
              ),
              child: const Text('JOGAR'),
            ),
            const SizedBox(height: 20),
            const Text('por Rebeca Alves Moreira', style: TextStyle(color: Color(0x55FFFFFF), fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});
  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  List<List<int>> mundo = [];
  int blocoSelecionado = 1;
  double offsetX = 0, offsetY = 0;
  double zoom = 1.0;
  Offset? _startPan;
  double _startOffX = 0, _startOffY = 0;
  bool pausado = false;
  int blocosColocados = 0;

  @override
  void initState() {
    super.initState();
    _carregarMundo();
  }

  Future<void> _carregarMundo() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('mundo_v2');
    if (saved != null) {
      final list = saved.split(',').map(int.parse).toList();
      mundo = List.generate(kMundoSize, (x) => List.generate(kMundoSize, (z) => list[x * kMundoSize + z]));
      blocosColocados = prefs.getInt('blocos') ?? 0;
    } else {
      _gerarMundo();
    }
    setState(() {});
  }

  void _gerarMundo() {
    final rng = Random();
    mundo = List.generate(kMundoSize, (x) => List.generate(kMundoSize, (z) {
      final r = rng.nextDouble();
      if (r < 0.35) return TipoBloco.grama.index;
      if (r < 0.50) return TipoBloco.terra.index;
      if (r < 0.62) return TipoBloco.areia.index;
      if (r < 0.72) return TipoBloco.pedra.index;
      if (r < 0.80) return TipoBloco.madeira.index;
      if (r < 0.87) return TipoBloco.folha.index;
      if (r < 0.92) return TipoBloco.agua.index;
      return TipoBloco.vazio.index;
    }));
  }

  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance();
    final flat = mundo.expand((row) => row).join(',');
    await prefs.setString('mundo_v2', flat);
    await prefs.setInt('blocos', blocosColocados);
  }

  Offset _isoPos(int x, int z, Size size) {
    const tw = 56.0, th = 28.0;
    return Offset(
      size.width / 2 + offsetX + (x - z) * tw * zoom / 2,
      size.height * 0.3 + offsetY + (x + z) * th * zoom / 2,
    );
  }

  void _onTap(Offset pos, Size size) {
    const tw = 56.0, th = 28.0;
    final bx = size.width / 2 + offsetX;
    final by = size.height * 0.3 + offsetY;
    final dx = pos.dx - bx, dy = pos.dy - by;
    final fx = (dx / (tw * zoom / 2) + dy / (th * zoom / 2)) / 2;
    final fz = (dy / (th * zoom / 2) - dx / (tw * zoom / 2)) / 2;
    final gx = fx.round(), gz = fz.round();
    if (gx >= 0 && gx < kMundoSize && gz >= 0 && gz < kMundoSize) {
      setState(() {
        if (mundo[gx][gz] == blocoSelecionado) {
          mundo[gx][gz] = TipoBloco.vazio.index;
          blocosColocados = (blocosColocados - 1).clamp(0, 99999);
        } else {
          mundo[gx][gz] = blocoSelecionado;
          blocosColocados++;
        }
      });
      _salvar();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mundo.isEmpty) return const Scaffold(body: Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50))));
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (d) { if (!pausado) { final size = MediaQuery.of(context).size; _onTap(d.localPosition, Size(size.width, size.height - 84)); } },
            onScaleStart: (d) { _startPan = d.localFocalPoint; _startOffX = offsetX; _startOffY = offsetY; },
            onScaleUpdate: (d) {
              setState(() {
                if (d.pointerCount == 1) {
                  offsetX = _startOffX + d.localFocalPoint.dx - _startPan!.dx;
                  offsetY = _startOffY + d.localFocalPoint.dy - _startPan!.dy;
                } else {
                  zoom = (zoom * d.scale).clamp(0.4, 2.5);
                }
              });
            },
            child: CustomPaint(
              painter: MundoPainter(mundo: mundo, isoPos: _isoPos, zoom: zoom),
              size: Size.infinite,
            ),
          ),
          _buildHUD(),
          if (pausado) _buildPausa(),
        ],
      ),
    );
  }

  Widget _buildHUD() => Column(
    children: [
      Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              const Text('CC', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 12),
              const Text('Construcao Criativa da Rebeca', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('Blocos: $blocosColocados', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 13)),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () => setState(() => pausado = true),
                child: const Text('PAUSAR', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
      const Spacer(),
      Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Text('Selecionado: ${kBlocoNomes[blocoSelecionado]}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(TipoBloco.values.length - 1, (i) {
                    final idx = i + 1;
                    return GestureDetector(
                      onTap: () => setState(() => blocoSelecionado = idx),
                      child: Container(
                        width: 48, height: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: kBlocoCores[idx],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blocoSelecionado == idx ? const Color(0xFFFFD700) : Colors.white24, width: blocoSelecionado == idx ? 3 : 1.5),
                          boxShadow: blocoSelecionado == idx ? [const BoxShadow(color: Color(0xAAFFD700), blurRadius: 10)] : null,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildPausa() => GestureDetector(
    onTap: () {},
    child: Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('PAUSADO', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => pausado = false),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14)),
              child: const Text('Continuar'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MenuPrincipal())),
              child: const Text('Menu Principal', style: TextStyle(color: Colors.white54)),
            ),
          ],
        ),
      ),
    ),
  );
}

class MundoPainter extends CustomPainter {
  final List<List<int>> mundo;
  final Offset Function(int, int, Size) isoPos;
  final double zoom;
  MundoPainter({required this.mundo, required this.isoPos, required this.zoom});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final g = LinearGradient(colors: [const Color(0xFF87CEEB), const Color(0xFFB3E5FC), const Color(0xFFDCEDC8)]);
    paint.shader = g.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    paint.shader = null;
    final N = mundo.length;
    const tw = 56.0, th = 28.0, td = 20.0;
    for (int x = 0; x < N; x++) {
      for (int z = 0; z < N; z++) {
        final bi = mundo[x][z];
        if (bi <= 0) continue;
        final p = isoPos(x, z, size);
        final sc = zoom;
        final tw2 = tw * sc / 2, th2 = th * sc / 2, td2 = td * sc;
        _drawBlock(canvas, p, tw2, th2, td2, bi);
      }
    }
    // Draw Rebeca character
    final cp = isoPos(N ~/ 2, N ~/ 2, size);
    _drawRebeca(canvas, cp, zoom);
  }

  void _drawBlock(Canvas canvas, Offset p, double tw, double th, double td, int bi) {
    final paint = Paint()..style = PaintingStyle.fill;
    // Top face
    final top = Path()
      ..moveTo(p.dx, p.dy - td)
      ..lineTo(p.dx + tw, p.dy - td + th)
      ..lineTo(p.dx, p.dy - td + th * 2)
      ..lineTo(p.dx - tw, p.dy - td + th)
      ..close();
    paint.color = kBlocoCores[bi];
    canvas.drawPath(top, paint);
    // Right face
    final right = Path()
      ..moveTo(p.dx + tw, p.dy - td + th)
      ..lineTo(p.dx + tw, p.dy + th)
      ..lineTo(p.dx, p.dy + th * 2)
      ..lineTo(p.dx, p.dy - td + th * 2)
      ..close();
    paint.color = kBlocoLateral[bi];
    canvas.drawPath(right, paint);
    // Left face
    final left = Path()
      ..moveTo(p.dx - tw, p.dy - td + th)
      ..lineTo(p.dx, p.dy - td + th * 2)
      ..lineTo(p.dx, p.dy + th * 2)
      ..lineTo(p.dx - tw, p.dy + th)
      ..close();
    paint.color = kBlocoSombra[bi];
    canvas.drawPath(left, paint);
    // Outline
    final outline = Paint()..style = PaintingStyle.stroke..color = const Color(0x33000000)..strokeWidth = 0.8;
    canvas.drawPath(top, outline);
    canvas.drawPath(right, outline);
    canvas.drawPath(left, outline);
  }

  void _drawRebeca(Canvas canvas, Offset p, double sc) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rx = p.dx, ry = p.dy - 20 * sc;
    // Hair
    paint.color = const Color(0xFFFFD700);
    canvas.drawRect(Rect.fromLTWH(rx - 7 * sc, ry - 32 * sc, 14 * sc, 8 * sc), paint);
    // Face
    paint.color = const Color(0xFFFFDBA9);
    canvas.drawRect(Rect.fromLTWH(rx - 6 * sc, ry - 24 * sc, 12 * sc, 14 * sc), paint);
    // Body
    paint.color = const Color(0xFF9C27B0);
    canvas.drawRect(Rect.fromLTWH(rx - 5 * sc, ry - 10 * sc, 10 * sc, 13 * sc), paint);
    // Legs
    paint.color = const Color(0xFF3F51B5);
    canvas.drawRect(Rect.fromLTWH(rx - 5 * sc, ry + 3 * sc, 4 * sc, 9 * sc), paint);
    canvas.drawRect(Rect.fromLTWH(rx + 1 * sc, ry + 3 * sc, 4 * sc, 9 * sc), paint);
    // Arms
    paint.color = const Color(0xFFFFDBA9);
    canvas.drawRect(Rect.fromLTWH(rx - 8 * sc, ry - 8 * sc, 3 * sc, 8 * sc), paint);
    canvas.drawRect(Rect.fromLTWH(rx + 5 * sc, ry - 8 * sc, 3 * sc, 8 * sc), paint);
  }

  @override
  bool shouldRepaint(MundoPainter old) => true;
}
