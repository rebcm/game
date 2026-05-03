import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';

class Rebeca {
  double x, y, z;
  double vx = 0, vy = 0, vz = 0;
  TipoBloco blocoSelecionado = TipoBloco.grama;
  int slotAtual = 0;

  static const List<TipoBloco> hotbar = [
    TipoBloco.grama, TipoBloco.terra, TipoBloco.pedra, TipoBloco.areia,
    TipoBloco.madeira, TipoBloco.tijolo, TipoBloco.ouro, TipoBloco.diamante,
  ];

  Rebeca({required this.x, required this.y, required this.z});

  void mover(double dx, double dz, double dt, Mundo mundo) {
    final vel = Constantes.velocidade;
    final nx = x + dx * vel * dt;
    final nz = z + dz * vel * dt;
    if (!mundo.isSolido(nx.round(), y.round(), z.round())) x = nx;
    if (!mundo.isSolido(x.round(), y.round(), nz.round())) z = nz;
    x = x.clamp(0.0, Constantes.worldX - 1.0);
    z = z.clamp(0.0, Constantes.worldZ - 1.0);
  }

  void subirDescer(double dy, double dt) {
    y = (y + dy * Constantes.velocidade * dt).clamp(5.0, Constantes.worldY - 1.0);
  }

  void selecionarSlot(int slot) {
    slotAtual = slot.clamp(0, hotbar.length - 1);
    blocoSelecionado = hotbar[slotAtual];
  }

  double get telaX => (x - z) * Constantes.halfW;
  double get telaY => (x + z) * Constantes.halfH - y * Constantes.sideH;
}
