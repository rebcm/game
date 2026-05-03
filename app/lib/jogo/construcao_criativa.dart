import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/renderizador/renderizador_isometrico.dart';

class ConstrucaoCriativa extends FlameGame {
  late Mundo mundo;
  late Rebeca rebeca;
  final RenderizadorIsometrico _renderer = RenderizadorIsometrico();
  double _joyX = 0, _joyZ = 0, _joyY = 0;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    mundo = Mundo();
    rebeca = Rebeca(x: Constantes.worldX / 2.0, y: 8.0, z: Constantes.worldZ / 2.0);
    overlays.add('controles');
  }

  @override
  void update(double dt) {
    super.update(dt);
    rebeca.mover(_joyX, _joyZ, dt, mundo);
    if (_joyY != 0) rebeca.subirDescer(_joyY, dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _renderer.render(canvas, mundo, rebeca, size);
  }

  void setJoystick(double dx, double dz) { _joyX = dx; _joyZ = dz; }
  void setVertical(double dy) { _joyY = dy; }

  void colocarBloco() {
    final bx = (rebeca.x + 1).round().clamp(0, mundo.largura - 1);
    final by = rebeca.y.round().clamp(0, mundo.altura - 1);
    final bz = rebeca.z.round().clamp(0, mundo.profundidade - 1);
    if (!mundo.isSolido(bx, by, bz)) mundo.set(bx, by, bz, rebeca.blocoSelecionado);
  }

  void quebrarBloco() {
    final bx = (rebeca.x + 1).round().clamp(0, mundo.largura - 1);
    final by = rebeca.y.round().clamp(0, mundo.altura - 1);
    final bz = rebeca.z.round().clamp(0, mundo.profundidade - 1);
    mundo.set(bx, by, bz, TipoBloco.ar);
  }

  void selecionarSlot(int slot) => rebeca.selecionarSlot(slot);
}
