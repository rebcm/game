import 'dart:math';

import 'package:rebcm/mundo/mundo.dart';

/// Tipos de criatura.
enum TipoMob {
  vaca,
  galinha,
  porco,
  zumbi,
  ovelha,
  esqueleto,
  aranha,
  creeper,
  lobo, // amigável, ataca zumbis se próximo
}

extension TipoMobProps on TipoMob {
  bool get hostil =>
      this == TipoMob.zumbi ||
      this == TipoMob.esqueleto ||
      this == TipoMob.aranha ||
      this == TipoMob.creeper;
  bool get amigavel => this == TipoMob.lobo;

  /// Vida máxima do mob.
  int get hpMax {
    switch (this) {
      case TipoMob.vaca: return 8;
      case TipoMob.galinha: return 4;
      case TipoMob.porco: return 6;
      case TipoMob.zumbi: return 16;
      case TipoMob.ovelha: return 8;
      case TipoMob.esqueleto: return 14;
      case TipoMob.aranha: return 12;
      case TipoMob.creeper: return 10;
      case TipoMob.lobo: return 12;
    }
  }

  double get velocidade {
    switch (this) {
      case TipoMob.vaca: return 1.4;
      case TipoMob.galinha: return 1.7;
      case TipoMob.porco: return 1.5;
      case TipoMob.zumbi: return 2.2;
      case TipoMob.ovelha: return 1.3;
      case TipoMob.esqueleto: return 1.8;
      case TipoMob.aranha: return 2.6;
      case TipoMob.creeper: return 1.9;
      case TipoMob.lobo: return 2.4;
    }
  }

  int get corARGB {
    switch (this) {
      case TipoMob.vaca: return 0xFFFFFFFF;
      case TipoMob.galinha: return 0xFFFFF59D;
      case TipoMob.porco: return 0xFFF8BBD0;
      case TipoMob.zumbi: return 0xFF4CAF50;
      case TipoMob.ovelha: return 0xFFFAFAFA;
      case TipoMob.esqueleto: return 0xFFE0E0E0;
      case TipoMob.aranha: return 0xFF263238;
      case TipoMob.creeper: return 0xFF2E7D32;
      case TipoMob.lobo: return 0xFF9E9E9E;
    }
  }

  int get corARGBSecundaria {
    switch (this) {
      case TipoMob.vaca: return 0xFF424242;
      case TipoMob.galinha: return 0xFFFF6F00;
      case TipoMob.porco: return 0xFFEC407A;
      case TipoMob.zumbi: return 0xFF2E7D32;
      case TipoMob.ovelha: return 0xFFEEEEEE;
      case TipoMob.esqueleto: return 0xFF9E9E9E;
      case TipoMob.aranha: return 0xFFB71C1C;
      case TipoMob.creeper: return 0xFF1B5E20;
      case TipoMob.lobo: return 0xFFEEEEEE;
    }
  }

  String get nome {
    switch (this) {
      case TipoMob.vaca: return 'Vaca';
      case TipoMob.galinha: return 'Galinha';
      case TipoMob.porco: return 'Porco';
      case TipoMob.zumbi: return 'Zumbi';
      case TipoMob.ovelha: return 'Ovelha';
      case TipoMob.esqueleto: return 'Esqueleto';
      case TipoMob.aranha: return 'Aranha';
      case TipoMob.creeper: return 'Creeper';
      case TipoMob.lobo: return 'Lobo';
    }
  }

  /// Distância máxima a que o mob pode atacar/agir contra o player.
  double get alcanceAtaque {
    switch (this) {
      case TipoMob.zumbi:
      case TipoMob.aranha: return 1.8;
      case TipoMob.esqueleto: return 8.0; // ranged
      case TipoMob.creeper: return 2.0;   // explode quando perto
      default: return 0.0;
    }
  }

  /// Dano causado por um ataque do mob ao player.
  int get danoAtaque {
    switch (this) {
      case TipoMob.zumbi: return 2;
      case TipoMob.aranha: return 3;
      case TipoMob.esqueleto: return 2;
      case TipoMob.creeper: return 8; // explosão
      default: return 0;
    }
  }
}

/// Entidade simples sobre o terreno. Não tem física vertical real — sempre
/// repousa em `mundo.alturaSuperficie(x, z) + 1`.
class Mob {
  final TipoMob tipo;
  double x;
  double y;
  double z;
  double direcao;
  int hp;
  double _proximoMudanca = 0.0;

  Mob({
    required this.tipo,
    required this.x,
    required this.y,
    required this.z,
    this.direcao = 0,
  }) : hp = tipo.hpMax;

  bool get vivo => hp > 0;

  /// Atualiza posição. Se [perseguir] for não-nulo (player x,z) e o mob é
  /// hostil, anda em direção ao alvo. Caso contrário vagueia aleatoriamente.
  void atualizar(double dt, Mundo mundo, {(double, double)? perseguirAlvo}) {
    if (!vivo) return;

    final rng = Random((x * 1e3 + z * 7 + tipo.index).toInt());

    if (tipo.hostil && perseguirAlvo != null) {
      final dx = perseguirAlvo.$1 - x;
      final dz = perseguirAlvo.$2 - z;
      direcao = atan2(dz, dx);
    } else {
      _proximoMudanca -= dt;
      if (_proximoMudanca <= 0) {
        direcao = rng.nextDouble() * 2 * pi;
        _proximoMudanca = 1.5 + rng.nextDouble() * 3.0;
      }
    }

    final v = tipo.velocidade;
    final nx = x + cos(direcao) * v * dt;
    final nz = z + sin(direcao) * v * dt;

    // Não atravessa parede sólida.
    if (!mundo.isSolido(nx.round(), y.round(), z.round())) x = nx;
    if (!mundo.isSolido(x.round(), y.round(), nz.round())) z = nz;

    // Mantém na superfície (gravidade simplificada).
    final h = mundo.alturaSuperficie(x.round(), z.round());
    y = (h + 1).toDouble();
  }

  /// Aplica dano e retorna `true` se o mob morreu nesse hit.
  bool aplicarDano(int d) {
    hp -= d;
    return !vivo;
  }
}
