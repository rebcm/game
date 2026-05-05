import 'dart:math' as math;

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebcm/audio/audio.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/inventario/drops.dart';
import 'package:rebcm/inventario/inventario.dart';
import 'package:rebcm/inventario/item.dart';
import 'package:rebcm/mob/mob.dart';
import 'package:rebcm/mob/spawner.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/mundo/save_load.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/renderizador/renderizador_isometrico.dart';

class ConstrucaoCriativa extends FlameGame
    with TapCallbacks, KeyboardEvents {
  late Mundo mundo;
  late Rebeca rebeca;
  final RenderizadorIsometrico _renderer = RenderizadorIsometrico();
  final MobSpawner mobs = MobSpawner();
  final Inventario inv = Inventario();

  // HP/fome reais.
  int hp = 20;
  int hpMax = 20;
  int fome = 20;
  int fomeMax = 20;
  bool morto = false;

  /// Modo de jogo. true = creative (voo livre, sem dano de queda, blocos
  /// infinitos no inv… na próxima iteração); false = survival (gravidade
  /// real, dano de queda, recursos limitados).
  bool creative = true;

  // Tempo desde último dano para regen.
  double _semDano = 0.0;
  double _accFome = 0.0;
  double _accRegen = 0.0;
  double _accDanoTerreno = 0.0;

  // Spawn point para respawn.
  double spawnX = 0, spawnY = 0, spawnZ = 0;

  double _joyX = 0, _joyZ = 0, _joyY = 0;
  bool _quebrando = false;

  int _ultimoCx = 0, _ultimoCz = 0;
  bool _chunksInicializados = false;
  double _segundosDesdeSave = 0.0;

  double tempoDia = 0.25;
  static const double _diaSegundos = 240.0;

  final ValueNotifier<String?> mensagem = ValueNotifier<String?>(null);
  // Notificações para a UI re-renderizar quando algo importante muda.
  final ValueNotifier<int> hudTick = ValueNotifier<int>(0);

  int get camAngle => _renderer.camAngle;

  /// Bloco selecionado vindo do inventário (null se slot atual não é bloco).
  TipoBloco? get blocoSelecionado => inv.blocoSelecionado;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    final save = await SaveLoad.carregar();
    if (save != null) {
      mundo = Mundo(seed: save.seed);
      SaveLoad.aplicarOverrides(mundo.chunks, save);
      rebeca = Rebeca(x: save.px, y: save.py, z: save.pz);
      inv.selecionarSlot(save.hotbarSlot);
      if (save.tempoDia != null) tempoDia = save.tempoDia!;
      if (save.hp != null) hp = save.hp!.clamp(0, hpMax);
      if (save.fome != null) fome = save.fome!.clamp(0, fomeMax);
      if (save.inventario != null) {
        SaveLoad.aplicarInventario(inv, save.inventario!);
      } else {
        _kitInicial();
      }
      mensagem.value = 'Mundo carregado';
    } else {
      mundo = Mundo();
      final spawnXi = Constantes.chunkSize ~/ 2;
      final spawnZi = Constantes.chunkSize ~/ 2;
      final hSurf = mundo.alturaSuperficie(spawnXi, spawnZi);
      rebeca = Rebeca(
        x: spawnXi.toDouble(),
        y: (hSurf + 5).toDouble(),
        z: spawnZi.toDouble(),
      );
      _kitInicial();
      mensagem.value = 'Bem-vinda! Hotbar com kit inicial';
    }
    spawnX = rebeca.x;
    spawnY = rebeca.y;
    spawnZ = rebeca.z;

    rebeca.atualizarAlvoManual(mundo);
    overlays.add('controles');

    final cs = Constantes.chunkSize;
    _ultimoCx = (rebeca.x / cs).floor();
    _ultimoCz = (rebeca.z / cs).floor();
    mundo.atualizarChunksProximos(rebeca.x, rebeca.z);
    _chunksInicializados = true;
  }

  /// Itens iniciais para um novo mundo: blocos básicos + 1 picareta de
  /// madeira para já permitir minerar pedra.
  void _kitInicial() {
    inv.adicionar(Item.bloco(TipoBloco.grama, qtd: 32));
    inv.adicionar(Item.bloco(TipoBloco.terra, qtd: 32));
    inv.adicionar(Item.bloco(TipoBloco.pedra, qtd: 16));
    inv.adicionar(Item.bloco(TipoBloco.madeira, qtd: 16));
    inv.adicionar(Item.bloco(TipoBloco.folha, qtd: 16));
    inv.adicionar(Item.bloco(TipoBloco.tijolo, qtd: 8));
    inv.adicionar(Item.bloco(TipoBloco.vidro, qtd: 8));
    inv.adicionar(Item.bloco(TipoBloco.luz, qtd: 4));
    inv.adicionar(Item.item(TipoItem.picaretaMadeira));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (morto) return;

    rebeca.mover(_joyX, _joyZ, dt, mundo);
    if (creative) {
      // Voo livre: subir/descer manual, sem gravidade.
      if (_joyY != 0) rebeca.subirDescer(_joyY, dt);
    } else {
      // Survival: gravidade. _joyY > 0 vira pulo; _joyY < 0 ignorado.
      if (_joyY > 0) rebeca.pular();
      final queda = rebeca.aplicarGravidade(dt, mundo);
      if (queda > 4.0) {
        final dano = (queda - 3).round();
        if (dano > 0) _aplicarDano(dano, 'queda ${queda.toStringAsFixed(1)} blocos');
      }
    }

    if (_quebrando) {
      final alvo = rebeca.blocoAlvo;
      if (alvo != null && mundo.isSolido(alvo.x, alvo.y, alvo.z)) {
        // Velocidade de quebra depende da ferramenta vs bloco.
        final bloco = mundo.get(alvo.x, alvo.y, alvo.z);
        final tier = inv.melhorPicareta;
        final ferramenta = inv.itemSelecionado?.item?.ferramenta;
        final mult = Drops.velocidadeQuebra(bloco, tier, ferramenta);
        rebeca.progressoQuebra += (dt / Constantes.tempoQuebra) * mult;
        if (rebeca.progressoQuebra >= 1.0) {
          rebeca.progressoQuebra = 0.0;
          _quebrarComDrops(alvo.x, alvo.y, alvo.z, bloco);
          rebeca.atualizarAlvoManual(mundo);
        }
      } else {
        rebeca.cancelarQuebra();
      }
    }

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

    tempoDia = (tempoDia + dt / _diaSegundos) % 1.0;
    final sun = (0.5 + 0.5 * math.sin(tempoDia * 2 * math.pi - math.pi / 2))
        .clamp(0.05, 1.0);
    _renderer.luzDia = sun;
    _renderer.tempoDia = tempoDia;
    _renderer.tempoAnim += dt;

    mobs.atualizar(dt, mundo, rebeca.x, rebeca.z, sun);
    mobs.atualizarMobs(dt, mundo, rebeca.x, rebeca.z);

    _atualizarSobrevivencia(dt);

    _segundosDesdeSave += dt;
    if (_segundosDesdeSave >= Constantes.autosavePeriodo) {
      _segundosDesdeSave = 0.0;
      _autoSave();
    }

    hudTick.value++;
  }

  /// Sobrevivência: dano por terreno (lava/cacto), zumbi adjacente,
  /// fome decrescente, regen HP quando fome cheia.
  void _atualizarSobrevivencia(double dt) {
    _semDano += dt;

    // Bloco em que o player está pisando ou dentro: lava ou cacto = dano
    // contínuo.
    final bx = rebeca.x.round();
    final by = rebeca.y.round();
    final bz = rebeca.z.round();
    final blocoNoCorpo = mundo.get(bx, by, bz);
    final blocoNosPes = mundo.get(bx, by - 1, bz);
    _accDanoTerreno += dt;
    if (_accDanoTerreno >= 0.5) {
      _accDanoTerreno = 0.0;
      if (blocoNoCorpo == TipoBloco.lava || blocoNosPes == TipoBloco.lava) {
        _aplicarDano(3, 'lava');
      } else if (blocoNoCorpo == TipoBloco.cacto || blocoNosPes == TipoBloco.cacto) {
        _aplicarDano(1, 'cacto');
      }
    }

    // Hostis: cada tipo ataca conforme alcanceAtaque + danoAtaque,
    // respeitando cooldown global de 1s por dano recebido.
    if (_semDano >= 1.0) {
      for (final m in mobs.mobs) {
        if (!m.tipo.hostil) continue;
        final dx = m.x - rebeca.x;
        final dy = m.y - rebeca.y;
        final dz = m.z - rebeca.z;
        final d2 = dx * dx + dy * dy + dz * dz;
        final alc = m.tipo.alcanceAtaque;
        if (alc == 0) continue;
        if (d2 > alc * alc) continue;
        if (m.tipo == TipoMob.creeper && d2 < 4.0) {
          // Creeper explode: dano 8 + remove blocos em raio 2.
          _explosao(m.x, m.y, m.z, 2);
          _aplicarDano(m.tipo.danoAtaque, 'creeper');
          m.aplicarDano(m.tipo.hpMax); // creeper morre na explosão
          break;
        } else {
          _aplicarDano(m.tipo.danoAtaque, m.tipo.nome.toLowerCase());
          break;
        }
      }
    }

    // Fome decresce ~1 ponto a cada 30s.
    _accFome += dt;
    if (_accFome >= 30.0 && fome > 0) {
      _accFome = 0.0;
      fome -= 1;
    }

    // Regen HP: se fome >= 18 E sem dano há 4s+ E hp < max.
    _accRegen += dt;
    if (fome >= 18 && _semDano >= 4.0 && hp < hpMax && _accRegen >= 4.0) {
      _accRegen = 0.0;
      hp += 1;
    }
  }

  void _aplicarDano(int d, String fonte) {
    if (morto) return;
    hp -= d;
    _semDano = 0.0;
    Audio.hit();
    if (hp <= 0) {
      hp = 0;
      morto = true;
      mensagem.value = 'Você morreu! ($fonte) — toque para reviver';
    } else {
      mensagem.value = '-$d HP ($fonte)';
    }
  }

  void respawnar() {
    if (!morto) return;
    rebeca.x = spawnX;
    rebeca.y = spawnY;
    rebeca.z = spawnZ;
    hp = hpMax;
    fome = fomeMax;
    morto = false;
    rebeca.atualizarAlvoManual(mundo);
    Audio.respawn();
    mensagem.value = 'Respawn no ponto inicial';
  }

  /// Quebra o bloco em (bx,by,bz), gera drops conforme ferramenta atual e
  /// adiciona ao inventário (descartando se não couber).
  void _quebrarComDrops(int bx, int by, int bz, TipoBloco bloco) {
    final tier = inv.melhorPicareta;
    final drops = Drops.dropDeBloco(bloco, tier);
    mundo.set(bx, by, bz, TipoBloco.ar);
    Audio.quebrar();
    for (final d in drops) {
      inv.adicionar(d);
    }
  }

  Future<void> _autoSave() async {
    final ok = await SaveLoad.salvar(
      chunks: mundo.chunks,
      px: rebeca.x,
      py: rebeca.y,
      pz: rebeca.z,
      hotbarSlot: inv.slotSelecionado,
      hp: hp,
      fome: fome,
      tempoDia: tempoDia,
      inventario: SaveLoad.serializarInventario(inv),
    );
    if (ok) {
      mensagem.value = 'Auto-save ✓';
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _renderer.render(
      canvas,
      mundo,
      rebeca,
      size,
      mobs: mobs.mobs,
      blocoMao: blocoSelecionado,
    );
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
    if (keysPressed.contains(LogicalKeyboardKey.space)) _joyY = 1.0;
    if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) _joyY = -1.0;

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyR) _renderer.rotacionarCamera();
      if (event.logicalKey == LogicalKeyboardKey.keyF) atacarMobProximo();
      if (event.logicalKey == LogicalKeyboardKey.keyE) comerSlotAtual();
      if (event.logicalKey == LogicalKeyboardKey.keyG) alternarModo();
      if (event.logicalKey == LogicalKeyboardKey.space && !creative) rebeca.pular();
      // 1..9: selecionar slot da hotbar.
      const digitos = [
        LogicalKeyboardKey.digit1, LogicalKeyboardKey.digit2,
        LogicalKeyboardKey.digit3, LogicalKeyboardKey.digit4,
        LogicalKeyboardKey.digit5, LogicalKeyboardKey.digit6,
        LogicalKeyboardKey.digit7, LogicalKeyboardKey.digit8,
        LogicalKeyboardKey.digit9,
      ];
      for (int i = 0; i < digitos.length; i++) {
        if (event.logicalKey == digitos[i]) {
          selecionarSlot(i);
          break;
        }
      }
    }

    return KeyEventResult.handled;
  }

  /// Atacar mob com dano que escala com a melhor espada do inventário.
  bool atacarMobProximo() {
    if (morto) return false;
    final m = mobs.maisProximo(rebeca.x, rebeca.y, rebeca.z, Constantes.alcanceBloco);
    if (m == null) return false;
    final tier = inv.melhorEspada;
    final dano = 2 + tier.index * 2;
    Audio.atacar();
    final morreu = m.aplicarDano(dano);
    if (morreu) {
      final drops = Drops.dropDeMob(m.tipo);
      for (final d in drops) {
        inv.adicionar(d);
      }
      mensagem.value = '${m.tipo.nome} derrotado! +${drops.length} drop';
    } else {
      mensagem.value = 'Atingiu ${m.tipo.nome} (-$dano)';
    }
    return morreu;
  }

  /// Come o item da hotbar atual se for comestível. Restaura fome e
  /// pode causar dano por carne crua/podre (5% de chance).
  void comerSlotAtual() {
    if (morto) return;
    final s = inv.itemSelecionado;
    if (s == null || !s.isItem || !s.item!.comestivel) {
      mensagem.value = 'Nada comestível selecionado';
      return;
    }
    final restaurar = s.item!.nutricao;
    fome = (fome + restaurar).clamp(0, fomeMax);
    inv.consumirSlotAtual();
    Audio.comer();
    if (s.item!.suspeito && math.Random().nextDouble() < 0.15) {
      _aplicarDano(1, 'comida estragada');
    } else {
      mensagem.value = 'Comeu ${s.item!.nome} (+$restaurar fome)';
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (morto) {
      respawnar();
      return;
    }
    colocarBloco();
  }

  void setJoystick(double dx, double dz) {
    _joyX = dx;
    _joyZ = dz;
  }

  void setVertical(double dy) => _joyY = dy;

  void iniciarQuebra() {
    if (morto) return;
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
    final bloco = blocoSelecionado;
    if (bloco == null) return;

    final by = (alvo.y + 1).clamp(0, Constantes.worldY - 1);
    if (!mundo.isSolido(alvo.x, by, alvo.z)) {
      mundo.set(alvo.x, by, alvo.z, bloco);
      inv.consumirSlotAtual();
      Audio.colocar();
    } else if (!mundo.isSolido(alvo.x, alvo.y, alvo.z)) {
      mundo.set(alvo.x, alvo.y, alvo.z, bloco);
      inv.consumirSlotAtual();
      Audio.colocar();
    }
  }

  void quebrarBlocoImediato() {
    final alvo = rebeca.blocoAlvo;
    if (alvo == null) return;
    final bloco = mundo.get(alvo.x, alvo.y, alvo.z);
    if (bloco == TipoBloco.ar) return;
    _quebrarComDrops(alvo.x, alvo.y, alvo.z, bloco);
    rebeca.cancelarQuebra();
    rebeca.atualizarAlvoManual(mundo);
  }

  void rotacionarCamera() => _renderer.rotacionarCamera();

  /// Alterna entre criativo (voo livre, sem dano de queda) e sobrevivência
  /// (gravidade, dano de queda). Disponível em qualquer momento.
  void alternarModo() {
    creative = !creative;
    if (creative) {
      rebeca.vy = 0;
      rebeca.noChao = true;
      rebeca.yMaxQueda = rebeca.y;
    }
    mensagem.value = creative ? 'Modo Criativo (voo)' : 'Modo Sobrevivência (gravidade)';
  }

  /// Explosão estilo creeper: remove todos os blocos sólidos em raio
  /// [raio] do ponto (cx, cy, cz). Drop dos blocos é descartado para
  /// não inundar o inventário.
  void _explosao(double cxF, double cyF, double czF, int raio) {
    final cx = cxF.round();
    final cy = cyF.round();
    final cz = czF.round();
    for (int dx = -raio; dx <= raio; dx++) {
      for (int dy = -raio; dy <= raio; dy++) {
        for (int dz = -raio; dz <= raio; dz++) {
          if (dx * dx + dy * dy + dz * dz > raio * raio) continue;
          final bx = cx + dx;
          final by = cy + dy;
          final bz = cz + dz;
          final b = mundo.get(bx, by, bz);
          if (b == TipoBloco.ar || b == TipoBloco.obsidiana) continue;
          mundo.set(bx, by, bz, TipoBloco.ar);
        }
      }
    }
    Audio.hit();
  }

  /// Verifica se há um workbench em raio 3 do player. Habilita receitas
  /// avançadas no painel de craft.
  bool get workbenchProximo {
    final px = rebeca.x.round();
    final py = rebeca.y.round();
    final pz = rebeca.z.round();
    for (int dx = -3; dx <= 3; dx++) {
      for (int dz = -3; dz <= 3; dz++) {
        for (int dy = -2; dy <= 2; dy++) {
          if (mundo.get(px + dx, py + dy, pz + dz) == TipoBloco.workbench) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void selecionarSlot(int slot) {
    inv.selecionarSlot(slot);
    rebeca.resetQuebra();
  }

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

  Future<bool> salvarAgora() async {
    final ok = await SaveLoad.salvar(
      chunks: mundo.chunks,
      px: rebeca.x,
      py: rebeca.y,
      pz: rebeca.z,
      hotbarSlot: inv.slotSelecionado,
      hp: hp,
      fome: fome,
      tempoDia: tempoDia,
      inventario: SaveLoad.serializarInventario(inv),
    );
    mensagem.value = ok ? 'Salvo!' : 'Erro ao salvar';
    return ok;
  }

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
    inv.selecionarSlot(save.hotbarSlot);
    if (save.tempoDia != null) tempoDia = save.tempoDia!;
    if (save.hp != null) hp = save.hp!.clamp(0, hpMax);
    if (save.fome != null) fome = save.fome!.clamp(0, fomeMax);
    inv.limpar();
    if (save.inventario != null) {
      SaveLoad.aplicarInventario(inv, save.inventario!);
    } else {
      _kitInicial();
    }
    morto = false;
    rebeca.atualizarAlvoManual(mundo);
    final cs = Constantes.chunkSize;
    _ultimoCx = (rebeca.x / cs).floor();
    _ultimoCz = (rebeca.z / cs).floor();
    mundo.atualizarChunksProximos(rebeca.x, rebeca.z);
    mensagem.value = 'Carregado!';
    return true;
  }

  Future<bool> apagarSave() async {
    final ok = await SaveLoad.apagar();
    mensagem.value = ok ? 'Save apagado' : 'Sem save';
    return ok;
  }
}
