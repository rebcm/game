import 'dart:math';

import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mob/mob.dart';
import 'package:rebcm/mundo/mundo.dart';

/// Spawner determinístico (por chunk + tempo do dia).
///
/// Ao redor do player, a cada segundo, tenta spawnar 0..N mobs por chunk
/// dentro de [Constantes.viewRadius] - 1, respeitando um cap global.
/// Mobs hostis (zumbi) só nascem à noite.
class MobSpawner {
  final List<Mob> mobs = [];
  double _acumulador = 0.0;
  static const double _intervalo = 1.5;
  static const int _capGlobal = 18;
  static const int _maxPorTick = 2;

  /// Tenta spawnar novos mobs em chunks adjacentes ao player.
  void atualizar(
    double dt,
    Mundo mundo,
    double playerX,
    double playerZ,
    double luzDia,
  ) {
    _acumulador += dt;
    if (_acumulador < _intervalo) return;
    _acumulador = 0.0;

    if (mobs.length >= _capGlobal) return;

    final cs = Constantes.chunkSize;
    final pcx = (playerX / cs).floor();
    final pcz = (playerZ / cs).floor();
    final r = Constantes.viewRadius - 1;
    final rng = Random();

    int spawned = 0;
    for (int dcx = -r; dcx <= r && spawned < _maxPorTick; dcx++) {
      for (int dcz = -r; dcz <= r && spawned < _maxPorTick; dcz++) {
        // Skip o chunk do player para não spawnar em cima dele.
        if (dcx == 0 && dcz == 0) continue;
        // 8% de chance de tentar spawn nesse chunk a cada tick.
        if (rng.nextDouble() > 0.08) continue;

        final cx = pcx + dcx;
        final cz = pcz + dcz;
        // Posição aleatória dentro do chunk.
        final lx = rng.nextInt(cs);
        final lz = rng.nextInt(cs);
        final gx = cx * cs + lx;
        final gz = cz * cs + lz;

        // Só spawna em terreno aberto sobre grama/areia.
        final h = mundo.alturaSuperficie(gx, gz);
        final superficie = mundo.get(gx, h, gz);
        if (superficie != TipoBloco.grama && superficie != TipoBloco.areia) {
          continue;
        }
        // Não spawna se já há um bloco logo acima (teto).
        if (mundo.isSolido(gx, h + 1, gz)) continue;

        // Escolhe o tipo: hostis à noite, passivos de dia.
        final TipoMob tipo;
        if (luzDia < 0.3 && rng.nextDouble() < 0.45) {
          tipo = TipoMob.zumbi;
        } else if (luzDia >= 0.3) {
          final r2 = rng.nextDouble();
          if (r2 < 0.45) {
            tipo = TipoMob.vaca;
          } else if (r2 < 0.75) {
            tipo = TipoMob.galinha;
          } else {
            tipo = TipoMob.porco;
          }
        } else {
          continue; // noite, mas não spawnou zumbi: pula
        }

        mobs.add(Mob(
          tipo: tipo,
          x: gx.toDouble(),
          y: (h + 1).toDouble(),
          z: gz.toDouble(),
          direcao: rng.nextDouble() * 6.283,
        ));
        spawned++;
      }
    }
  }

  /// Atualiza todos os mobs vivos. Mobs muito longe do player são
  /// despawnados para liberar memória.
  void atualizarMobs(double dt, Mundo mundo, double playerX, double playerZ) {
    final cap = (Constantes.chunkSize * (Constantes.viewRadius + 1)).toDouble();
    mobs.removeWhere((m) {
      if (!m.vivo) return true;
      final dx = m.x - playerX;
      final dz = m.z - playerZ;
      // Despawn se sai do view 1.5x.
      if (dx * dx + dz * dz > (cap * 1.5) * (cap * 1.5)) return true;
      return false;
    });

    for (final m in mobs) {
      final perseguir = m.tipo.hostil ? (playerX, playerZ) : null;
      m.atualizar(dt, mundo, perseguirAlvo: perseguir);
    }
  }

  /// Encontra o mob mais próximo do player dentro de [alcance], ou null.
  Mob? maisProximo(double px, double py, double pz, double alcance) {
    Mob? melhor;
    double melhorD = alcance * alcance;
    for (final m in mobs) {
      final dx = m.x - px;
      final dy = m.y - py;
      final dz = m.z - pz;
      final d = dx * dx + dy * dy + dz * dz;
      if (d < melhorD) {
        melhor = m;
        melhorD = d;
      }
    }
    return melhor;
  }

  void limpar() => mobs.clear();
}
