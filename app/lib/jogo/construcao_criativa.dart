import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/renderizador/renderizador_isometrico.dart';

class ConstrucaoCriativa extends FlameGame
    with TapCallbacks, KeyboardEvents {
  late Mundo mundo;
  late Rebeca rebeca;
  final RenderizadorIsometrico _renderer = RenderizadorIsometrico();

  double _joyX = 0, _joyZ = 0, _joyY = 0;
  bool _quebrando = false;

  // Expose camera angle for UI
  int get camAngle => _renderer.camAngle;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    mundo = Mundo();
    rebeca = Rebeca(
      x: Constantes.worldX / 2.0,
      y: 10.0,
      z: Constantes.worldZ / 2.0,
    );
    rebeca.atualizarAlvoManual(mundo);
    overlays.add('controles');
  }

  @override
  void update(double dt) {
    super.update(dt);
    rebeca.mover(_joyX, _joyZ, dt, mundo);
    if (_joyY != 0) rebeca.subirDescer(_joyY, dt);

    if (_quebrando) {
      final alvo = rebeca.blocoAlvo;
      if (alvo != null && mundo.isSolido(alvo.x, alvo.y, alvo.z)) {
        if (rebeca.avancarQuebra(dt)) {
          mundo.set(alvo.x, alvo.y, alvo.z, TipoBloco.ar);
          rebeca.atualizarAlvoManual(mundo);
        }
      } else {
        rebeca.cancelarQuebra();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _renderer.render(canvas, mundo, rebeca, size);
  }

  // Keyboard support (desktop / web)
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const speed = 1.0;
    _joyX = 0;
    _joyZ = 0;
    _joyY = 0;

    if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      _joyX = speed * 0.7;
      _joyZ = speed * 0.7;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      _joyX = -speed * 0.7;
      _joyZ = -speed * 0.7;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _joyX = -speed * 0.7;
      _joyZ = speed * 0.7;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _joyX = speed * 0.7;
      _joyZ = -speed * 0.7;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _joyY = 1.0;
    }
    if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      _joyY = -1.0;
    }

    // R = rotate camera
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.keyR) {
      _renderer.rotacionarCamera();
    }

    return KeyEventResult.handled;
  }

  // Tap = place block (touch / mouse left click)
  @override
  void onTapUp(TapUpEvent event) {
    colocarBloco();
  }

  void setJoystick(double dx, double dz) {
    _joyX = dx;
    _joyZ = dz;
  }

  void setVertical(double dy) => _joyY = dy;

  void iniciarQuebra() {
    _quebrando = true;
    rebeca.atualizarAlvoManual(mundo);
  }

  void pararQuebra() {
    _quebrando = false;
    rebeca.cancelarQuebra();
  }

  void colocarBloco() {
    final alvo = rebeca.blocoAlvo;
    if (alvo == null) return;

    // Place on top of target block
    final by = (alvo.y + 1).clamp(0, mundo.altura - 1);
    if (!mundo.isSolido(alvo.x, by, alvo.z)) {
      mundo.set(alvo.x, by, alvo.z, rebeca.blocoSelecionado);
    } else if (!mundo.isSolido(alvo.x, alvo.y, alvo.z)) {
      mundo.set(alvo.x, alvo.y, alvo.z, rebeca.blocoSelecionado);
    }
  }

  void quebrarBlocoImediato() {
    final alvo = rebeca.blocoAlvo;
    if (alvo == null) return;
    mundo.set(alvo.x, alvo.y, alvo.z, TipoBloco.ar);
    rebeca.cancelarQuebra();
    rebeca.atualizarAlvoManual(mundo);
  }

  void rotacionarCamera() => _renderer.rotacionarCamera();

  void selecionarSlot(int slot) => rebeca.selecionarSlot(slot);

  String get coordenadas =>
      'X:${rebeca.x.toStringAsFixed(1)} '
      'Y:${rebeca.y.toStringAsFixed(1)} '
      'Z:${rebeca.z.toStringAsFixed(1)}';
}
