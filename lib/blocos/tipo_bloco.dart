import 'package:flutter/material.dart';

enum TipoBloco {
  ar,
  grama,
  terra,
  pedra,
  areia,
  agua,
  madeira,
  folhas,
  vidro,
  tijolos,
  neve,
  tronco,
  ouro,
  diamante,
  luz,
}

extension TipoBlocoExt on TipoBloco {
  String get nome {
    switch (this) {
      case TipoBloco.ar: return 'Ar';
      case TipoBloco.grama: return 'Grama';
      case TipoBloco.terra: return 'Terra';
      case TipoBloco.pedra: return 'Pedra';
      case TipoBloco.areia: return 'Areia';
      case TipoBloco.agua: return 'Água';
      case TipoBloco.madeira: return 'Madeira';
      case TipoBloco.folhas: return 'Folhas';
      case TipoBloco.vidro: return 'Vidro';
      case TipoBloco.tijolos: return 'Tijolos';
      case TipoBloco.neve: return 'Neve';
      case TipoBloco.tronco: return 'Tronco';
      case TipoBloco.ouro: return 'Ouro';
      case TipoBloco.diamante: return 'Diamante';
      case TipoBloco.luz: return 'Luz';
    }
  }

  bool get solido => this != TipoBloco.ar && this != TipoBloco.agua;
  bool get transparente => this == TipoBloco.ar || this == TipoBloco.vidro || this == TipoBloco.agua;
  bool get emiteLuz => this == TipoBloco.luz;

  Color get cor {
    switch (this) {
      case TipoBloco.ar: return Colors.transparent;
      case TipoBloco.grama: return const Color(0xFF4CAF50);
      case TipoBloco.terra: return const Color(0xFF795548);
      case TipoBloco.pedra: return const Color(0xFF9E9E9E);
      case TipoBloco.areia: return const Color(0xFFFFEB3B);
      case TipoBloco.agua: return const Color(0x882196F3);
      case TipoBloco.madeira: return const Color(0xFF8D6E63);
      case TipoBloco.folhas: return const Color(0xFF388E3C);
      case TipoBloco.vidro: return const Color(0x44B3E5FC);
      case TipoBloco.tijolos: return const Color(0xFFB71C1C);
      case TipoBloco.neve: return const Color(0xFFF5F5F5);
      case TipoBloco.tronco: return const Color(0xFF6D4C41);
      case TipoBloco.ouro: return const Color(0xFFFFD700);
      case TipoBloco.diamante: return const Color(0xFF00BCD4);
      case TipoBloco.luz: return const Color(0xFFFFF176);
    }
  }
}
