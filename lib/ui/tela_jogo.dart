import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../jogo/estado_jogo.dart';
import '../jogo/renderizador_isometrico.dart';
import '../personagem/rebeca.dart';
import '../blocos/tipo_bloco.dart';
import 'hud.dart';

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  Offset? _offsetArrasto;
  double _escala = 1.0;
  double _escalaBase = 1.0;

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<EstadoJogo>();
    if (estado.mundo == null || estado.rebeca == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (e) => _tratarTeclado(e, estado),
        child: Stack(
          children: [
            // Renderização do mundo
            GestureDetector(
              onScaleStart: (d) => _escalaBase = _escala,
              onScaleUpdate: (d) {
                setState(() {
                  _escala = (_escalaBase * d.scale).clamp(0.4, 3.0);
                });
                if (d.pointerCount == 1) {
                  _moverPersonagem(d.focalPointDelta, estado.rebeca!);
                }
              },
              onTapDown: (d) => _tocarBloco(d.localPosition, estado),
              child: CustomPaint(
                painter: RenderizadorIsometrico(
                  mundo: estado.mundo!,
                  rebeca: estado.rebeca!,
                  escala: _escala,
                ),
                child: const SizedBox.expand(),
              ),
            ),
            // HUD
            HUD(estado: estado),
            // Botão de pausa
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                onPressed: () => _mostrarPausa(context, estado),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tratarTeclado(KeyEvent evento, EstadoJogo estado) {
    if (evento is! KeyDownEvent) return;
    final rebeca = estado.rebeca!;
    const passo = 1.0;

    if (evento.logicalKey == LogicalKeyboardKey.arrowUp ||
        evento.logicalKey == LogicalKeyboardKey.keyW) {
      rebeca.moverPara(rebeca.x, rebeca.y, rebeca.z - passo);
      rebeca.virarPara(DirecaoOlhar.norte);
    } else if (evento.logicalKey == LogicalKeyboardKey.arrowDown ||
        evento.logicalKey == LogicalKeyboardKey.keyS) {
      rebeca.moverPara(rebeca.x, rebeca.y, rebeca.z + passo);
      rebeca.virarPara(DirecaoOlhar.sul);
    } else if (evento.logicalKey == LogicalKeyboardKey.arrowLeft ||
        evento.logicalKey == LogicalKeyboardKey.keyA) {
      rebeca.moverPara(rebeca.x - passo, rebeca.y, rebeca.z);
      rebeca.virarPara(DirecaoOlhar.oeste);
    } else if (evento.logicalKey == LogicalKeyboardKey.arrowRight ||
        evento.logicalKey == LogicalKeyboardKey.keyD) {
      rebeca.moverPara(rebeca.x + passo, rebeca.y, rebeca.z);
      rebeca.virarPara(DirecaoOlhar.leste);
    } else if (evento.logicalKey == LogicalKeyboardKey.space) {
      rebeca.moverPara(rebeca.x, rebeca.y + 1, rebeca.z);
    } else if (evento.logicalKey == LogicalKeyboardKey.shiftLeft) {
      rebeca.moverPara(rebeca.x, rebeca.y - 1, rebeca.z);
    } else if (evento.logicalKey == LogicalKeyboardKey.keyE) {
      estado.abrirInventario();
    } else {
      // Slots 1-9
      for (var i = 0; i < 9; i++) {
        if (evento.character == '${i + 1}') {
          rebeca.selecionarSlot(i);
        }
      }
    }
  }

  void _moverPersonagem(Offset delta, Rebeca rebeca) {
    const sensibilidade = 0.05;
    rebeca.moverPara(
      rebeca.x + delta.dx * sensibilidade,
      rebeca.y,
      rebeca.z + delta.dy * sensibilidade,
    );
  }

  void _tocarBloco(Offset toque, EstadoJogo estado) {
    final rebeca = estado.rebeca!;
    final posFrente = rebeca.blocoDaFrente;

    final blocoExistente = estado.mundo!.pegarBloco(posFrente);
    if (blocoExistente == TipoBloco.ar) {
      // Colocar bloco
      estado.mundo!.definirBloco(posFrente, rebeca.blocoSelecionado);
      estado.blocoColocado();
    } else {
      // Remover bloco
      estado.mundo!.definirBloco(posFrente, TipoBloco.ar);
      estado.blocoRemovido();
    }
    setState(() {});
  }

  void _mostrarPausa(BuildContext ctx, EstadoJogo estado) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Pausado', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Continuar'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                estado.voltarInicio();
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Sair para o Menu',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
