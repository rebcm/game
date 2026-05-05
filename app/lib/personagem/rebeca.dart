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
  double vy = 0; // velocidade vertical (gravidade no modo survival)
  double direcao = pi / 4; // NE por padrão

  // Quebra em curso (alvo + progresso 0..1).
  BlocoAlvo? blocoAlvo;
  double progressoQuebra = 0.0;

  // Para detecção de queda: y mais alto que o player atingiu desde o
  // último contato com o chão.
  double yMaxQueda = 0.0;
  bool noChao = true;

  // Gravidade: aceleração para baixo e cap de velocidade terminal.
  static const double gravidade = -22.0;
  static const double velTerminal = -32.0;
  static const double pulo = 8.5;

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

  /// Vôo livre (modo creative): movimento direto em Y.
  void subirDescer(double dy, double dt) {
    y = (y + dy * Constantes.velocidade * dt).clamp(1.0, Constantes.worldY - 1.0);
    yMaxQueda = y;
    noChao = true;
  }

  /// Aplica gravidade e detecta colisão com o chão. Retorna a altura de
  /// queda (em blocos) se aterrissou neste frame; 0 caso contrário.
  /// O caller decide se transforma a queda em dano (modo survival).
  double aplicarGravidade(double dt, Mundo mundo) {
    vy += gravidade * dt;
    if (vy < velTerminal) vy = velTerminal;
    final ny = y + vy * dt;

    // Bloco alvo (cabeça/pés do player). Player ocupa ~1 bloco vertical.
    final px = x.round();
    final pz = z.round();

    if (vy < 0) {
      // Caindo: chão = bloco em (px, floor(ny)-1, pz)? Verificar pé do
      // player aproximadamente em y-0.0; bloco abaixo é (floor(y)-1).
      final yFloor = ny.floor();
      if (mundo.isSolido(px, yFloor, pz)) {
        // Aterrissou em yFloor+1.
        final landY = yFloor + 1.0;
        final delta = yMaxQueda - landY;
        y = landY;
        vy = 0;
        noChao = true;
        yMaxQueda = y;
        return delta > 0 ? delta : 0;
      } else {
        y = ny;
        noChao = false;
        return 0;
      }
    } else {
      // Subindo (após pulo): teto = bloco acima da cabeça.
      final yCeil = (ny + 1).floor();
      if (mundo.isSolido(px, yCeil, pz)) {
        vy = 0;
        return 0;
      } else {
        y = ny;
        if (y > yMaxQueda) yMaxQueda = y;
        return 0;
      }
    }
  }

  /// Tenta pular (apenas se está no chão).
  void pular() {
    if (noChao) {
      vy = pulo;
      noChao = false;
    }
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
