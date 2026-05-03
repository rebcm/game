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
}

extension TipoBlocoProps on TipoBloco {
  bool get solido => this != TipoBloco.ar;
  bool get transparente =>
      this == TipoBloco.ar ||
      this == TipoBloco.vidro ||
      this == TipoBloco.folha;
  bool get emiteLuz => this == TipoBloco.luz;

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
