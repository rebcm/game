import 'dart:math' as math;

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/mundo/save_load.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/renderizador/renderizador_isometrico.dart';

class ConstrucaoCriativa extends FlameGame
    with TapCallbacks, KeyboardEvents {
  late Mundo mundo;
  late Rebeca rebeca;
  final RenderizadorIsometrico _renderer = RenderizadorIsometrico();

  double _joyX = 0, _joyZ = 0, _joyY = 0;
  bool _quebrando = false;

  // Throttle: lembra o último chunk em que o player estava para só
  // recarregar vizinhos quando atravessa a borda.
  int _ultimoCx = 0, _ultimoCz = 0;
  bool _chunksInicializados = false;

  // Auto-save.
  double _segundosDesdeSave = 0.0;

  // Ciclo dia/noite — fração 0..1 de um dia completo.
  // 0 = nascer do sol, 0.25 = meio-dia, 0.5 = pôr do sol, 0.75 = meia-noite.
  double tempoDia = 0.25;
  static const double _diaSegundos = 240.0; // 4 minutos = 1 dia completo

  // Notificações para a UI (atualiza badges save/load).
  final ValueNotifier<String?> mensagem = ValueNotifier<String?>(null);

  int get camAngle => _renderer.camAngle;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    // Tenta carregar save existente; senão começa um mundo novo.
    final save = await SaveLoad.carregar();
    if (save != null) {
      mundo = Mundo(seed: save.seed);
      SaveLoad.aplicarOverrides(mundo.chunks, save);
      rebeca = Rebeca(x: save.px, y: save.py, z: save.pz);
      rebeca.selecionarSlot(save.hotbarSlot);
      if (save.tempoDia != null) tempoDia = save.tempoDia!;
      mensagem.value = 'Mundo carregado';
    } else {
      mundo = Mundo();
      // Spawn no centro do "chunk 0,0", em cima do terreno.
      final spawnX = Constantes.chunkSize ~/ 2;
      final spawnZ = Constantes.chunkSize ~/ 2;
      final hSurf = mundo.alturaSuperficie(spawnX, spawnZ);
      rebeca = Rebeca(
        x: spawnX.toDouble(),
        y: (hSurf + 5).toDouble(),
        z: spawnZ.toDouble(),
      );
      mensagem.value = 'Bem-vinda ao novo mundo!';
    }

    rebeca.atualizarAlvoManual(mundo);
    overlays.add('controles');

    // Garante chunks ao redor do spawn.
    final cs = Constantes.chunkSize;
    _ultimoCx = (rebeca.x / cs).floor();
    _ultimoCz = (rebeca.z / cs).floor();
    mundo.atualizarChunksProximos(rebeca.x, rebeca.z);
    _chunksInicializados = true;
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

    // Atualiza chunks ao atravessar borda.
    if (_chunksInicializados) {
      final cs = Constantes.chunkSize;
      final cx = (rebeca.x / cs).floor();
      final cz = (rebeca.z / cs).floor();
      if (cx != _ultimoCx || cz != _ultimoCz) {
        mundo.atualizarChunksProximos(rebeca.x, rebeca.z);
        _ultimoCx = cx;
        _ultimoCz = cz;
      }
    }

    // Ciclo dia/noite. Pico de luz em tempoDia=0.25 (meio-dia), mínimo em 0.75.
    tempoDia = (tempoDia + dt / _diaSegundos) % 1.0;
    final sun = (0.5 + 0.5 * math.sin(tempoDia * 2 * math.pi - math.pi / 2))
        .clamp(0.05, 1.0);
    _renderer.luzDia = sun;

    // Auto-save.
    _segundosDesdeSave += dt;
    if (_segundosDesdeSave >= Constantes.autosavePeriodo) {
      _segundosDesdeSave = 0.0;
      _autoSave();
    }
  }

  Future<void> _autoSave() async {
    final ok = await SaveLoad.salvar(
      chunks: mundo.chunks,
      px: rebeca.x,
      py: rebeca.y,
      pz: rebeca.z,
      hotbarSlot: rebeca.slotAtual,
      tempoDia: tempoDia,
    );
    if (ok) {
      mensagem.value = 'Auto-save ✓';
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _renderer.render(canvas, mundo, rebeca, size);
  }

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

    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.keyR) {
      _renderer.rotacionarCamera();
    }

    return KeyEventResult.handled;
  }

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

    final by = (alvo.y + 1).clamp(0, Constantes.worldY - 1);
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

  String get textoTempoDia {
    final fr = (tempoDia * 24);
    final h = fr.floor();
    final m = ((fr - h) * 60).floor();
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  /// Save manual disparado por botão.
  Future<bool> salvarAgora() async {
    final ok = await SaveLoad.salvar(
      chunks: mundo.chunks,
      px: rebeca.x,
      py: rebeca.y,
      pz: rebeca.z,
      hotbarSlot: rebeca.slotAtual,
      tempoDia: tempoDia,
    );
    mensagem.value = ok ? 'Salvo!' : 'Erro ao salvar';
    return ok;
  }

  /// Carrega o save default sobre o mundo atual. Quase tudo é resetado.
  Future<bool> carregarAgora() async {
    final save = await SaveLoad.carregar();
    if (save == null) {
      mensagem.value = 'Sem save';
      return false;
    }
    mundo = Mundo(seed: save.seed);
    SaveLoad.aplicarOverrides(mundo.chunks, save);
    rebeca.x = save.px;
    rebeca.y = save.py;
    rebeca.z = save.pz;
    rebeca.selecionarSlot(save.hotbarSlot);
    if (save.tempoDia != null) tempoDia = save.tempoDia!;
    rebeca.atualizarAlvoManual(mundo);
    final cs = Constantes.chunkSize;
    _ultimoCx = (rebeca.x / cs).floor();
    _ultimoCz = (rebeca.z / cs).floor();
    mundo.atualizarChunksProximos(rebeca.x, rebeca.z);
    mensagem.value = 'Carregado!';
    return true;
  }

  /// Apaga o save persistido (mas o mundo em RAM continua).
  Future<bool> apagarSave() async {
    final ok = await SaveLoad.apagar();
    mensagem.value = ok ? 'Save apagado' : 'Sem save';
    return ok;
  }
}
