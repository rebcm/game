import 'dart:math';
import 'dart:typed_data';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';

/// Chunk: bloco de mundo de 16×16 colunas com altura de [Constantes.worldY].
///
/// Layout linear no Uint8List: index = y * (cs*cs) + lx * cs + lz, onde cs=16.
/// Cada byte armazena o índice do TipoBloco (0..12). Espaço por chunk:
/// 16 * 16 * Constantes.worldY bytes = 16 KiB para altura 64.
class Chunk {
  final int cx;
  final int cz;
  final Uint8List blocos;
  bool dirty = false; // foi modificado pelo player desde o último save?

  Chunk(this.cx, this.cz)
      : blocos = Uint8List(
          Constantes.chunkSize * Constantes.chunkSize * Constantes.worldY,
        );

  static int _idx(int lx, int y, int lz) {
    final cs = Constantes.chunkSize;
    return y * (cs * cs) + lx * cs + lz;
  }

  TipoBloco get(int lx, int y, int lz) {
    if (lx < 0 || lx >= Constantes.chunkSize) return TipoBloco.ar;
    if (lz < 0 || lz >= Constantes.chunkSize) return TipoBloco.ar;
    if (y < 0 || y >= Constantes.worldY) return TipoBloco.ar;
    return TipoBloco.values[blocos[_idx(lx, y, lz)]];
  }

  void set(int lx, int y, int lz, TipoBloco b) {
    if (lx < 0 || lx >= Constantes.chunkSize) return;
    if (lz < 0 || lz >= Constantes.chunkSize) return;
    if (y < 0 || y >= Constantes.worldY) return;
    blocos[_idx(lx, y, lz)] = b.index;
  }
}

/// Mundo dividido em chunks com geração procedural determinística.
///
/// Geração baseada em coordenadas globais (x, z), então a mesma seed produz
/// sempre o mesmo terreno em qualquer chunk. Modificações do player são
/// armazenadas como override por chunk e marcam o chunk como [Chunk.dirty]
/// para serem persistidas no save.
class ChunkMundo {
  final Map<int, Chunk> _chunks = {};
  final int seed;

  ChunkMundo({this.seed = 42});

  static int chunkKey(int cx, int cz) => (cx & 0xFFFF) | ((cz & 0xFFFF) << 16);

  /// Hash determinístico de um par (x, z) com sal.
  static int _hash2(int x, int z, int salt) {
    int h = (x * 73856093) ^ (z * 19349663) ^ salt;
    h = (h ^ (h >> 13)) & 0xFFFFFFFF;
    h = (h * 0x5bd1e995) & 0xFFFFFFFF;
    h = (h ^ (h >> 15)) & 0xFFFFFFFF;
    return h;
  }

  /// Altura do terreno em (x, z) global. Compatível com versão pré-chunks.
  int alturaTerreno(int x, int z) {
    // Escala global menor produz colinas/ondulações mais largas que blocos.
    final nx = x / 32.0;
    final nz = z / 32.0;
    double v = sin(nx * pi) * cos(nz * pi) * 0.45 +
        sin(nx * pi * 2.5 + 1.3) * sin(nz * pi * 1.7 + 0.8) * 0.30 +
        sin(nx * pi * 5.5 + 2.5) * cos(nz * pi * 3.5 + 1.9) * 0.15 +
        sin(nx * pi * 8.5 + 4.1) * sin(nz * pi * 6.5 + 3.3) * 0.10;
    v = (v + 1.0) / 2.0;
    final base = 6 + (v * 18).toInt();
    return base.clamp(2, Constantes.worldY - 8);
  }

  /// Bioma baseado em latitude (z) — altera material da superfície.
  TipoBloco _topoBioma(int x, int z, int h) {
    if (h <= 4) return TipoBloco.areia;
    if (h >= 18) return TipoBloco.neve;
    // Banda de neve em z muito positivo, areia em z muito negativo (deserto).
    if ((z + seed) % 256 > 200) return TipoBloco.neve;
    if ((z - seed) % 256 < -180) return TipoBloco.areia;
    return TipoBloco.grama;
  }

  /// Gera blocos base de um chunk (terreno + minérios + árvores).
  Chunk _gerarChunk(int cx, int cz) {
    final cs = Constantes.chunkSize;
    final c = Chunk(cx, cz);

    // 1) Terreno + minérios.
    for (int lx = 0; lx < cs; lx++) {
      for (int lz = 0; lz < cs; lz++) {
        final gx = cx * cs + lx;
        final gz = cz * cs + lz;
        final h = alturaTerreno(gx, gz);
        for (int y = 0; y <= h; y++) {
          TipoBloco b;
          if (y == 0) {
            b = TipoBloco.obsidiana; // bedrock visualmente distinto
          } else if (y == 1 || y == 2) {
            // Camada de lava ocasional no fundo (lagos profundos).
            final hh = _hash2(gx, gz, seed ^ 0xfee10);
            if ((hh & 0xFF) < 14) {
              b = TipoBloco.lava;
            } else {
              b = TipoBloco.pedra;
            }
          } else if (y < h - 3) {
            // Possíveis minérios em pedra subterrânea.
            final hh = _hash2(gx * 257 + y, gz, seed ^ 0xa1b2);
            final r = hh & 0xFF;
            if (y < 6 && r < 3) {
              b = TipoBloco.diamante;
            } else if (y < 10 && r < 6) {
              b = TipoBloco.ouro;
            } else if (y < 14 && r < 14) {
              b = TipoBloco.ferro;
            } else if (r < 26) {
              b = TipoBloco.carvao;
            } else {
              b = TipoBloco.pedra;
            }
          } else if (y < h) {
            b = TipoBloco.terra;
          } else {
            b = _topoBioma(gx, gz, h);
          }
          c.set(lx, y, lz, b);
        }
      }
    }

    // 2) Árvores deterministicamente esparsas, somente em grama.
    for (int lx = 0; lx < cs; lx++) {
      for (int lz = 0; lz < cs; lz++) {
        final gx = cx * cs + lx;
        final gz = cz * cs + lz;
        final h = alturaTerreno(gx, gz);
        if (h < 5 || h >= Constantes.worldY - 8) continue;
        if (c.get(lx, h, lz) != TipoBloco.grama) continue;
        if ((_hash2(gx, gz, seed ^ 0xc1c2c3) & 0xFF) >= 12) continue;
        _plantarArvore(c, lx, h + 1, lz);
      }
    }

    // 3) Cactos no deserto (areia).
    for (int lx = 0; lx < cs; lx++) {
      for (int lz = 0; lz < cs; lz++) {
        final gx = cx * cs + lx;
        final gz = cz * cs + lz;
        final h = alturaTerreno(gx, gz);
        if (h >= Constantes.worldY - 4) continue;
        if (c.get(lx, h, lz) != TipoBloco.areia) continue;
        if ((_hash2(gx, gz, seed ^ 0xcac10) & 0xFF) >= 6) continue;
        // Cacto de 1-3 blocos.
        final altCacto = 1 + ((_hash2(gx, gz, seed ^ 0xcac20) >> 8) & 0x2);
        for (int i = 1; i <= altCacto; i++) {
          if (h + i < Constantes.worldY) {
            c.set(lx, h + i, lz, TipoBloco.cacto);
          }
        }
      }
    }

    return c;
  }

  void _plantarArvore(Chunk c, int lx, int y, int lz) {
    // Tronco 4-6 blocos. Altura derivada determinísticamente das coords.
    final h = 4 + ((lx * 7 + lz * 3 + c.cx + c.cz) & 0x3);
    for (int i = 0; i < h; i++) {
      if (y + i < Constantes.worldY) c.set(lx, y + i, lz, TipoBloco.madeira);
    }
    // Copa 5x5 cubica perto do topo, sem substituir o tronco.
    for (int dx = -2; dx <= 2; dx++) {
      for (int dz = -2; dz <= 2; dz++) {
        for (int dy = h - 2; dy <= h + 1; dy++) {
          if (dx == 0 && dz == 0 && dy < h) continue;
          if (dx * dx + dz * dz > 5) continue;
          final tx = lx + dx;
          final tz = lz + dz;
          final ty = y + dy;
          if (tx < 0 || tx >= Constantes.chunkSize) continue;
          if (tz < 0 || tz >= Constantes.chunkSize) continue;
          if (ty < 0 || ty >= Constantes.worldY) continue;
          if (c.get(tx, ty, tz) == TipoBloco.ar) {
            c.set(tx, ty, tz, TipoBloco.folha);
          }
        }
      }
    }
    if (y + h < Constantes.worldY) c.set(lx, y + h, lz, TipoBloco.folha);
    if (y + h + 1 < Constantes.worldY) c.set(lx, y + h + 1, lz, TipoBloco.folha);
  }

  Chunk getChunk(int cx, int cz) {
    final k = chunkKey(cx, cz);
    var c = _chunks[k];
    if (c == null) {
      c = _gerarChunk(cx, cz);
      _chunks[k] = c;
    }
    return c;
  }

  bool hasChunk(int cx, int cz) => _chunks.containsKey(chunkKey(cx, cz));

  /// Lê bloco em coordenadas globais. Lazy-gera o chunk se necessário.
  TipoBloco get(int x, int y, int z) {
    if (y < 0 || y >= Constantes.worldY) return TipoBloco.ar;
    final cs = Constantes.chunkSize;
    final cx = x >= 0 ? x ~/ cs : ((x + 1) ~/ cs) - 1;
    final cz = z >= 0 ? z ~/ cs : ((z + 1) ~/ cs) - 1;
    final lx = x - cx * cs;
    final lz = z - cz * cs;
    return getChunk(cx, cz).get(lx, y, lz);
  }

  void set(int x, int y, int z, TipoBloco b) {
    if (y < 0 || y >= Constantes.worldY) return;
    final cs = Constantes.chunkSize;
    final cx = x >= 0 ? x ~/ cs : ((x + 1) ~/ cs) - 1;
    final cz = z >= 0 ? z ~/ cs : ((z + 1) ~/ cs) - 1;
    final lx = x - cx * cs;
    final lz = z - cz * cs;
    final c = getChunk(cx, cz);
    if (c.get(lx, y, lz) != b) {
      c.set(lx, y, lz, b);
      c.dirty = true;
    }
  }

  bool isSolido(int x, int y, int z) => get(x, y, z).solido;

  /// Y mais alto sólido em (x, z). 0 se nada sólido.
  int alturaSuperficie(int x, int z) {
    for (int y = Constantes.worldY - 1; y >= 0; y--) {
      if (isSolido(x, y, z)) return y;
    }
    return 0;
  }

  /// Garante que todos os chunks dentro do raio (em chunks) do player estão
  /// carregados. Chama-se a cada update do jogo.
  void garantirChunksAoRedor(int cxCenter, int czCenter, int raio) {
    for (int dx = -raio; dx <= raio; dx++) {
      for (int dz = -raio; dz <= raio; dz++) {
        getChunk(cxCenter + dx, czCenter + dz);
      }
    }
  }

  /// Substitui o conteúdo do chunk (cx, cz) com bytes vindos de um save.
  /// Marca o chunk resultante como dirty para que seja persistido novamente
  /// na próxima rodada de salvamento.
  void injetarChunk(int cx, int cz, Uint8List blocos) {
    final k = chunkKey(cx, cz);
    final c = Chunk(cx, cz);
    final n = c.blocos.length < blocos.length ? c.blocos.length : blocos.length;
    for (int i = 0; i < n; i++) {
      c.blocos[i] = blocos[i];
    }
    c.dirty = true;
    _chunks[k] = c;
  }

  Iterable<Chunk> chunksDirty() => _chunks.values.where((c) => c.dirty);
  Iterable<Chunk> todosChunks() => _chunks.values;

  void marcarLimpo(Chunk c) => c.dirty = false;
}
