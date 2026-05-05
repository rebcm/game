import 'package:rebcm/blocos/tipo_bloco.dart';

/// Tier de ferramenta — controla o que pode minerar e quão rápido.
enum TierFerramenta { mao, madeira, pedra, ferro, diamante }

/// Tipo de ferramenta.
enum TipoFerramenta { picareta, machado, pa, espada }

/// Tipos de item que NÃO são blocos (drops de mobs, ferramentas, comida).
enum TipoItem {
  // Comida
  carneCrua,
  carneCozida,
  ovo,
  carnePodre,

  // Materiais
  pranchas,
  pau,
  carvao,         // como item (de carvão de bloco)
  ferro,          // lingote
  ouro,           // lingote
  diamante,       // gema

  // Ferramentas (cada combinação tipo+tier vira um TipoItem distinto via index)
  picaretaMadeira,
  picaretaPedra,
  picaretaFerro,
  picaretaDiamante,
  machadoMadeira,
  machadoPedra,
  machadoFerro,
  espadaMadeira,
  espadaPedra,
  espadaFerro,
}

extension TipoItemProps on TipoItem {
  String get nome {
    switch (this) {
      case TipoItem.carneCrua: return 'Carne crua';
      case TipoItem.carneCozida: return 'Carne cozida';
      case TipoItem.ovo: return 'Ovo';
      case TipoItem.carnePodre: return 'Carne podre';
      case TipoItem.pranchas: return 'Pranchas';
      case TipoItem.pau: return 'Pau';
      case TipoItem.carvao: return 'Carvão';
      case TipoItem.ferro: return 'Lingote ferro';
      case TipoItem.ouro: return 'Lingote ouro';
      case TipoItem.diamante: return 'Diamante';
      case TipoItem.picaretaMadeira: return 'Picareta madeira';
      case TipoItem.picaretaPedra: return 'Picareta pedra';
      case TipoItem.picaretaFerro: return 'Picareta ferro';
      case TipoItem.picaretaDiamante: return 'Picareta diamante';
      case TipoItem.machadoMadeira: return 'Machado madeira';
      case TipoItem.machadoPedra: return 'Machado pedra';
      case TipoItem.machadoFerro: return 'Machado ferro';
      case TipoItem.espadaMadeira: return 'Espada madeira';
      case TipoItem.espadaPedra: return 'Espada pedra';
      case TipoItem.espadaFerro: return 'Espada ferro';
    }
  }

  String get icone {
    switch (this) {
      case TipoItem.carneCrua: return '🥩';
      case TipoItem.carneCozida: return '🍖';
      case TipoItem.ovo: return '🥚';
      case TipoItem.carnePodre: return '🦴';
      case TipoItem.pranchas: return '🟫';
      case TipoItem.pau: return '|';
      case TipoItem.carvao: return '⬛';
      case TipoItem.ferro: return '⚙';
      case TipoItem.ouro: return '🥇';
      case TipoItem.diamante: return '💎';
      case TipoItem.picaretaMadeira:
      case TipoItem.picaretaPedra:
      case TipoItem.picaretaFerro:
      case TipoItem.picaretaDiamante: return '⛏';
      case TipoItem.machadoMadeira:
      case TipoItem.machadoPedra:
      case TipoItem.machadoFerro: return '🪓';
      case TipoItem.espadaMadeira:
      case TipoItem.espadaPedra:
      case TipoItem.espadaFerro: return '⚔';
    }
  }

  /// Pontos de fome restaurados ao comer.
  int get nutricao {
    switch (this) {
      case TipoItem.carneCrua: return 3;
      case TipoItem.carneCozida: return 8;
      case TipoItem.ovo: return 1;
      case TipoItem.carnePodre: return 4;
      default: return 0;
    }
  }

  bool get comestivel => nutricao > 0;

  /// Se true, consumir tem chance de causar fome / dano (carne podre).
  bool get suspeito => this == TipoItem.carneCrua || this == TipoItem.carnePodre;

  /// Para ferramentas, o tier resultante.
  TierFerramenta get tier {
    switch (this) {
      case TipoItem.picaretaMadeira:
      case TipoItem.machadoMadeira:
      case TipoItem.espadaMadeira: return TierFerramenta.madeira;
      case TipoItem.picaretaPedra:
      case TipoItem.machadoPedra:
      case TipoItem.espadaPedra: return TierFerramenta.pedra;
      case TipoItem.picaretaFerro:
      case TipoItem.machadoFerro:
      case TipoItem.espadaFerro: return TierFerramenta.ferro;
      case TipoItem.picaretaDiamante: return TierFerramenta.diamante;
      default: return TierFerramenta.mao;
    }
  }

  /// Se item é uma ferramenta de algum tipo.
  TipoFerramenta? get ferramenta {
    switch (this) {
      case TipoItem.picaretaMadeira:
      case TipoItem.picaretaPedra:
      case TipoItem.picaretaFerro:
      case TipoItem.picaretaDiamante: return TipoFerramenta.picareta;
      case TipoItem.machadoMadeira:
      case TipoItem.machadoPedra:
      case TipoItem.machadoFerro: return TipoFerramenta.machado;
      case TipoItem.espadaMadeira:
      case TipoItem.espadaPedra:
      case TipoItem.espadaFerro: return TipoFerramenta.espada;
      default: return null;
    }
  }

  /// Stack máximo no slot.
  int get pilhaMax => ferramenta != null ? 1 : 64;
}

/// Um item ocupando um slot (bloco OU item-não-bloco) com uma quantidade.
/// Apenas um dos dois (bloco OU item) é definido.
class Item {
  final TipoBloco? bloco;
  final TipoItem? item;
  int qtd;

  Item.bloco(TipoBloco b, {this.qtd = 1})
      : bloco = b,
        item = null;

  Item.item(TipoItem i, {this.qtd = 1})
      : bloco = null,
        item = i;

  bool get isBloco => bloco != null;
  bool get isItem => item != null;

  String get nome {
    if (isBloco) return bloco!.nome;
    if (isItem) return item!.nome;
    return '?';
  }

  String get icone {
    if (isItem) return item!.icone;
    return '■';
  }

  int get pilhaMax {
    if (isItem) return item!.pilhaMax;
    return 64;
  }

  /// Tenta empilhar [outro] neste, retornando o que sobrou (ou null se cabe tudo).
  Item? empilhar(Item outro) {
    if (!combina(outro)) return outro;
    final espaco = pilhaMax - qtd;
    if (espaco <= 0) return outro;
    final mover = outro.qtd < espaco ? outro.qtd : espaco;
    qtd += mover;
    if (mover == outro.qtd) return null;
    return outro.isBloco
        ? Item.bloco(outro.bloco!, qtd: outro.qtd - mover)
        : Item.item(outro.item!, qtd: outro.qtd - mover);
  }

  bool combina(Item outro) {
    if (isBloco && outro.isBloco) return bloco == outro.bloco;
    if (isItem && outro.isItem) return item == outro.item;
    return false;
  }

  Item clone() => isBloco
      ? Item.bloco(bloco!, qtd: qtd)
      : Item.item(item!, qtd: qtd);
}
