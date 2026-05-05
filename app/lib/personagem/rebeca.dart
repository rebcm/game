import 'dart:math';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';

class BlocoAlvo {
  final int x, y, z;
  final String face;
  const BlocoAlvo(this.x, this.y, this.z, {this.face = 'top'});

  @override
  bool operator ==(Object other) =>
      other is BlocoAlvo && other.x == x && other.y == y && other.z == z;
  @override
  int get hashCode => x * 10000 + y * 100 + z;
}

class Rebeca {
  double x, y, z;
  double vx = 0, vy = 0, vz = 0;
  double direcao = pi / 4; // NE by default

  TipoBloco blocoSelecionado = TipoBloco.grama;
  int slotAtual = 0;

  BlocoAlvo? blocoAlvo;
  double progressoQuebra = 0.0;

  static const List<TipoBloco> hotbar = [
    TipoBloco.grama,
    TipoBloco.terra,
    TipoBloco.pedra,
    TipoBloco.areia,
    TipoBloco.madeira,
    TipoBloco.tijolo,
    TipoBloco.ouro,
    TipoBloco.diamante,
  ];

  Rebeca({required this.x, required this.y, required this.z});

  void mover(double dx, double dz, double dt, Mundo mundo) {
    if (dx != 0 || dz != 0) direcao = atan2(dz, dx);

    final vel = Constantes.velocidade;
    final nx = x + dx * vel * dt;
    final nz = z + dz * vel * dt;
    // Mundo infinito por chunks: sem clamp em x/z.
    if (!mundo.isSolido(nx.round(), y.round(), z.round())) x = nx;
    if (!mundo.isSolido(x.round(), y.round(), nz.round())) z = nz;
    _atualizarBlocoAlvo(mundo);
  }

  void subirDescer(double dy, double dt) {
    y = (y + dy * Constantes.velocidade * dt).clamp(1.0, Constantes.worldY - 1.0);
  }

  void selecionarSlot(int slot) {
    slotAtual = slot.clamp(0, hotbar.length - 1);
    blocoSelecionado = hotbar[slotAtual];
    progressoQuebra = 0.0;
  }

  void _atualizarBlocoAlvo(Mundo mundo) {
    final dx = cos(direcao);
    final dz = sin(direcao);
    final py = y.round();

    for (double step = 1.5; step <= Constantes.alcanceBloco; step += 0.5) {
      final tx = (x + dx * step).round();
      final tz = (z + dz * step).round();
      if (mundo.isSolido(tx, py, tz)) {
        blocoAlvo = BlocoAlvo(tx, py, tz);
        return;
      }
      if (mundo.isSolido(tx, py - 1, tz)) {
        blocoAlvo = BlocoAlvo(tx, py - 1, tz, face: 'top');
        return;
      }
    }
    final tx = (x + dx * 2).round();
    final tz = (z + dz * 2).round();
    blocoAlvo = BlocoAlvo(tx, py, tz);
  }

  void atualizarAlvoManual(Mundo mundo) => _atualizarBlocoAlvo(mundo);

  bool avancarQuebra(double dt) {
    progressoQuebra += dt / Constantes.tempoQuebra;
    if (progressoQuebra >= 1.0) {
      progressoQuebra = 0.0;
      return true;
    }
    return false;
  }

  void cancelarQuebra() => progressoQuebra = 0.0;

  double get telaX => (x - z) * Constantes.halfW;
  double get telaY => (x + z) * Constantes.halfH - y * Constantes.sideH;
}
