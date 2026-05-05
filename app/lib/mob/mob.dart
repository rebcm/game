import 'dart:math';

import 'package:rebcm/mundo/mundo.dart';

/// Tipos de criatura.
enum TipoMob {
  vaca,
  galinha,
  porco,
  zumbi,
}

extension TipoMobProps on TipoMob {
  bool get hostil => this == TipoMob.zumbi;

  /// Vida máxima do mob.
  int get hpMax {
    switch (this) {
      case TipoMob.vaca:
        return 8;
      case TipoMob.galinha:
        return 4;
      case TipoMob.porco:
        return 6;
      case TipoMob.zumbi:
        return 16;
    }
  }

  /// Velocidade base em blocos/segundo.
  double get velocidade {
    switch (this) {
      case TipoMob.vaca:
        return 1.4;
      case TipoMob.galinha:
        return 1.7;
      case TipoMob.porco:
        return 1.5;
      case TipoMob.zumbi:
        return 2.2;
    }
  }

  /// Cor principal do corpo (renderizada como diamante isométrico).
  int get corARGB {
    switch (this) {
      case TipoMob.vaca:
        return 0xFFFFFFFF;
      case TipoMob.galinha:
        return 0xFFFFF59D;
      case TipoMob.porco:
        return 0xFFF8BBD0;
      case TipoMob.zumbi:
        return 0xFF4CAF50;
    }
  }

  /// Cor secundária (manchas, sombra).
  int get corARGBSecundaria {
    switch (this) {
      case TipoMob.vaca:
        return 0xFF424242;
      case TipoMob.galinha:
        return 0xFFFF6F00;
      case TipoMob.porco:
        return 0xFFEC407A;
      case TipoMob.zumbi:
        return 0xFF2E7D32;
    }
  }

  String get nome {
    switch (this) {
      case TipoMob.vaca:
        return 'Vaca';
      case TipoMob.galinha:
        return 'Galinha';
      case TipoMob.porco:
        return 'Porco';
      case TipoMob.zumbi:
        return 'Zumbi';
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
