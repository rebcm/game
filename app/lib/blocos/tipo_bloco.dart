enum TipoBloco {
  grama,
  terra,
  pedra,
  madeira,
  folha,
  novoBloco,

  // Adicionar novos blocos aqui
}

extension TipoBlocoPropriedades on TipoBloco {
  String get nome {
    switch (this) {
      case TipoBloco.grama:
        return 'Grama';
      case TipoBloco.terra:
        return 'Terra';
      case TipoBloco.pedra:
        return 'Pedra';
      case TipoBloco.madeira:
        return 'Madeira';
      case TipoBloco.folha:
        return 'Folha';
      case TipoBloco.novoBloco:
        return Novo
      case TipoBloco.novoBloco:
        return Color(0xFFFFFFFF);

      case TipoBloco.novoBloco:
        return true;

      case TipoBloco.novoBloco:
        return false;

      case TipoBloco.novoBloco:
        return false;

      default:
        throw Exception('Bloco não implementado');
    }
  }

  Color get cor {
    switch (this) {
      case TipoBloco.grama:
        return Color(0xFF32CD32);
      case TipoBloco.terra:
        return Color(0xFF964B00);
      case TipoBloco.pedra:
        return Color(0xFF808080);
      case TipoBloco.madeira:
        return Color(0xFFA0522D);
      case TipoBloco.folha:
        return Color(0xFF3E8E41);
      case TipoBloco.novoBloco:
        return Novo
      case TipoBloco.novoBloco:
        return Color(0xFFFFFFFF);

      case TipoBloco.novoBloco:
        return true;

      case TipoBloco.novoBloco:
        return false;

      case TipoBloco.novoBloco:
        return false;

      default:
        throw Exception('Bloco não implementado');
    }
  }

  bool get solido {
    switch (this) {
      case TipoBloco.grama:
      case TipoBloco.terra:
      case TipoBloco.pedra:
      case TipoBloco.madeira:
        return true;
      case TipoBloco.folha:
        return false;
      case TipoBloco.novoBloco:
        return Novo
      case TipoBloco.novoBloco:
        return Color(0xFFFFFFFF);

      case TipoBloco.novoBloco:
        return true;

      case TipoBloco.novoBloco:
        return false;

      case TipoBloco.novoBloco:
        return false;

      default:
        throw Exception('Bloco não implementado');
    }
  }

  bool get transparente {
    switch (this) {
      case TipoBloco.folha:
        return true;
      case TipoBloco.novoBloco:
        return Novo
      case TipoBloco.novoBloco:
        return Color(0xFFFFFFFF);

      case TipoBloco.novoBloco:
        return true;

      case TipoBloco.novoBloco:
        return false;

      case TipoBloco.novoBloco:
        return false;

      default:
        return false;
    }
  }

  bool get emiteLuz {
    switch (this) {
      case TipoBloco.novoBloco:
        return Novo
      case TipoBloco.novoBloco:
        return Color(0xFFFFFFFF);

      case TipoBloco.novoBloco:
        return true;

      case TipoBloco.novoBloco:
        return false;

      case TipoBloco.novoBloco:
        return false;

      default:
        return false;
    }
  }
}
