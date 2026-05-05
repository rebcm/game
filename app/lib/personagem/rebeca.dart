import 'dart:math';
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

  // Quebra em curso (alvo + progresso 0..1).
  BlocoAlvo? blocoAlvo;
  double progressoQuebra = 0.0;

  // Para detecção de queda: y do último frame em que estava no chão.
  double yMaxQueda = 0.0;
  bool noChao = true;

  Rebeca({required this.x, required this.y, required this.z}) {
    yMaxQueda = y;
  }

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

  /// Reseta progressoQuebra ao trocar slot ou parar de quebrar.
  void resetQuebra() {
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
