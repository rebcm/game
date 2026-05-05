import 'dart:ui';

enum TipoBloco {
  ar,
  grama,
  terra,
  pedra,
  areia,
  madeira,
  folha,
  tijolo,
  vidro,
  ouro,
  diamante,
  luz,
  neve,
  carvao,
  ferro,
  cacto,
  agua,
  lava,
  obsidiana,
  workbench,   // bloco crafting (4 pranchas)
  la,          // wool (drop ovelha)
  tocha,       // ilumina e é colocada
}

extension TipoBlocoProps on TipoBloco {
  bool get solido =>
      this != TipoBloco.ar &&
      this != TipoBloco.tocha; // tocha não bloqueia colisão
  bool get transparente =>
      this == TipoBloco.ar ||
      this == TipoBloco.vidro ||
      this == TipoBloco.folha ||
      this == TipoBloco.agua ||
      this == TipoBloco.tocha;
  bool get emiteLuz =>
      this == TipoBloco.luz ||
      this == TipoBloco.lava ||
      this == TipoBloco.tocha;
  bool get liquido => this == TipoBloco.agua || this == TipoBloco.lava;
  bool get perigoso => this == TipoBloco.lava || this == TipoBloco.cacto;
  /// Intensidade da luz emitida (0..15 estilo Minecraft).
  int get nivelLuz {
    switch (this) {
      case TipoBloco.lava: return 15;
      case TipoBloco.luz: return 14;
      case TipoBloco.tocha: return 13;
      default: return 0;
    }
  }

  String get nome {
    switch (this) {
      case TipoBloco.ar: return 'Ar';
      case TipoBloco.grama: return 'Grama';
      case TipoBloco.terra: return 'Terra';
      case TipoBloco.pedra: return 'Pedra';
      case TipoBloco.areia: return 'Areia';
      case TipoBloco.madeira: return 'Madeira';
      case TipoBloco.folha: return 'Folha';
      case TipoBloco.tijolo: return 'Tijolo';
      case TipoBloco.vidro: return 'Vidro';
      case TipoBloco.ouro: return 'Ouro';
      case TipoBloco.diamante: return 'Diamante';
      case TipoBloco.luz: return 'Luz';
      case TipoBloco.neve: return 'Neve';
      case TipoBloco.carvao: return 'Carvão';
      case TipoBloco.ferro: return 'Ferro';
      case TipoBloco.cacto: return 'Cacto';
      case TipoBloco.agua: return 'Água';
      case TipoBloco.lava: return 'Lava';
      case TipoBloco.obsidiana: return 'Obsidiana';
      case TipoBloco.workbench: return 'Workbench';
      case TipoBloco.la: return 'Lã';
      case TipoBloco.tocha: return 'Tocha';
    }
  }

  Color get corTopo {
    switch (this) {
      case TipoBloco.ar: return const Color(0x00000000);
      case TipoBloco.grama: return const Color(0xFF4CAF50);
      case TipoBloco.terra: return const Color(0xFF8D6E63);
      case TipoBloco.pedra: return const Color(0xFF9E9E9E);
      case TipoBloco.areia: return const Color(0xFFFFEB3B);
      case TipoBloco.madeira: return const Color(0xFFA1887F);
      case TipoBloco.folha: return const Color(0xFF66BB6A);
      case TipoBloco.tijolo: return const Color(0xFFE57373);
      case TipoBloco.vidro: return const Color(0xAAB3E5FC);
      case TipoBloco.ouro: return const Color(0xFFFFD54F);
      case TipoBloco.diamante: return const Color(0xFF80DEEA);
      case TipoBloco.luz: return const Color(0xFFFFF9C4);
      case TipoBloco.neve: return const Color(0xFFECEFF1);
      case TipoBloco.carvao: return const Color(0xFF424242);
      case TipoBloco.ferro: return const Color(0xFFCFD8DC);
      case TipoBloco.cacto: return const Color(0xFF388E3C);
      case TipoBloco.agua: return const Color(0xCC2196F3);
      case TipoBloco.lava: return const Color(0xFFFF5722);
      case TipoBloco.obsidiana: return const Color(0xFF1A1A2E);
      case TipoBloco.workbench: return const Color(0xFF6D4C41);
      case TipoBloco.la: return const Color(0xFFFAFAFA);
      case TipoBloco.tocha: return const Color(0xFFFFB300);
    }
  }

  Color get corEsquerda {
    final c = corTopo;
    return Color.fromARGB(c.alpha, (c.red * 0.7).toInt(), (c.green * 0.7).toInt(), (c.blue * 0.7).toInt());
  }

  Color get corDireita {
    final c = corTopo;
    return Color.fromARGB(c.alpha, (c.red * 0.85).toInt(), (c.green * 0.85).toInt(), (c.blue * 0.85).toInt());
  }
}
