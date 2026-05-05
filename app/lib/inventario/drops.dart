import 'dart:math';

import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/inventario/item.dart';
import 'package:rebcm/mob/mob.dart';

/// Tabelas de drop de blocos quebrados e mobs derrotados.
class Drops {
  static final Random _rng = Random();

  /// O que cai quando um bloco é quebrado por uma ferramenta de [tier].
  /// Retorna lista vazia se o tier é insuficiente para minerar.
  /// Cobre os 18 TipoBloco. Folha tem chance de pau ou nada.
  static List<Item> dropDeBloco(TipoBloco bloco, TierFerramenta tier) {
    if (!_podeMinerar(bloco, tier)) return const [];
    switch (bloco) {
      case TipoBloco.ar:
        return const [];
      case TipoBloco.grama:
      case TipoBloco.terra:
        return [Item.bloco(TipoBloco.terra)];
      case TipoBloco.pedra:
        // Pedra com madeira+ vira pedra mineralizada; mão não consegue.
        return [Item.bloco(TipoBloco.pedra)];
      case TipoBloco.areia:
        return [Item.bloco(TipoBloco.areia)];
      case TipoBloco.madeira:
        return [Item.bloco(TipoBloco.madeira)];
      case TipoBloco.folha:
        // 5% de chance de pau, 95% nada. Em Minecraft é ~10% saplings.
        if (_rng.nextDouble() < 0.05) return [Item.item(TipoItem.pau)];
        return const [];
      case TipoBloco.tijolo:
        return [Item.bloco(TipoBloco.tijolo)];
      case TipoBloco.vidro:
        return const []; // quebra sem dropar
      case TipoBloco.ouro:
        return [Item.item(TipoItem.ouro)];
      case TipoBloco.diamante:
        return [Item.item(TipoItem.diamante)];
      case TipoBloco.luz:
        return [Item.bloco(TipoBloco.luz)];
      case TipoBloco.neve:
        return [Item.bloco(TipoBloco.neve)];
      case TipoBloco.carvao:
        return [Item.item(TipoItem.carvao)];
      case TipoBloco.ferro:
        return [Item.item(TipoItem.ferro)];
      case TipoBloco.cacto:
        return [Item.bloco(TipoBloco.cacto)];
      case TipoBloco.agua:
      case TipoBloco.lava:
        return const [];
      case TipoBloco.obsidiana:
        return [Item.bloco(TipoBloco.obsidiana)];
      case TipoBloco.workbench:
        return [Item.bloco(TipoBloco.workbench)];
      case TipoBloco.la:
        return [Item.bloco(TipoBloco.la)];
      case TipoBloco.tocha:
        return [Item.bloco(TipoBloco.tocha)];
    }
  }

  /// Verifica se a [tier] é suficiente para minerar [bloco].
  /// Em mãos só pega: terra/areia/grama/folha/madeira/tijolo/neve/cacto/luz.
  /// Madeira+ pega: pedra/carvão/cobblestone-like.
  /// Pedra+ pega: ferro/ouro.
  /// Ferro+ pega: diamante.
  /// Diamante+ pega: obsidiana.
  static bool _podeMinerar(TipoBloco b, TierFerramenta t) {
    switch (b) {
      case TipoBloco.diamante:
      case TipoBloco.ouro:
        return t.index >= TierFerramenta.ferro.index;
      case TipoBloco.ferro:
        return t.index >= TierFerramenta.pedra.index;
      case TipoBloco.pedra:
      case TipoBloco.carvao:
        return t.index >= TierFerramenta.madeira.index;
      case TipoBloco.obsidiana:
        return t.index >= TierFerramenta.diamante.index;
      // Esses caem com mão.
      case TipoBloco.grama:
      case TipoBloco.terra:
      case TipoBloco.areia:
      case TipoBloco.madeira:
      case TipoBloco.folha:
      case TipoBloco.tijolo:
      case TipoBloco.vidro:
      case TipoBloco.luz:
      case TipoBloco.neve:
      case TipoBloco.cacto:
      case TipoBloco.workbench:
      case TipoBloco.la:
      case TipoBloco.tocha:
        return true;
      case TipoBloco.ar:
      case TipoBloco.agua:
      case TipoBloco.lava:
        return false;
    }
  }

  /// Multiplicador de velocidade de quebra para essa ferramenta nesse bloco.
  /// Sem ferramenta apropriada, fica entre 0.6 (lento) e 1.0 (default).
  static double velocidadeQuebra(TipoBloco bloco, TierFerramenta tier, TipoFerramenta? f) {
    final pode = _podeMinerar(bloco, tier);
    if (!pode) return 0.4; // ainda quebra, mas demora muito
    // Picareta acelera blocos minerais; machado, madeira/folhas; pá, terra/areia.
    final categoria = _categoria(bloco);
    if (categoria == _Cat.pickable && f == TipoFerramenta.picareta) return 1.5 + tier.index * 0.4;
    if (categoria == _Cat.axable && f == TipoFerramenta.machado) return 1.4 + tier.index * 0.3;
    if (categoria == _Cat.shovel && f == TipoFerramenta.pa) return 1.5 + tier.index * 0.3;
    return 1.0;
  }

  static _Cat _categoria(TipoBloco b) {
    switch (b) {
      case TipoBloco.pedra:
      case TipoBloco.carvao:
      case TipoBloco.ferro:
      case TipoBloco.ouro:
      case TipoBloco.diamante:
      case TipoBloco.obsidiana:
      case TipoBloco.tijolo:
        return _Cat.pickable;
      case TipoBloco.madeira:
      case TipoBloco.folha:
        return _Cat.axable;
      case TipoBloco.terra:
      case TipoBloco.grama:
      case TipoBloco.areia:
      case TipoBloco.neve:
        return _Cat.shovel;
      default:
        return _Cat.outro;
    }
  }

  /// Drops ao matar um mob.
  static List<Item> dropDeMob(TipoMob t) {
    switch (t) {
      case TipoMob.vaca:
        return [
          Item.item(TipoItem.carneCrua, qtd: 1 + _rng.nextInt(2)),
        ];
      case TipoMob.galinha:
        return [
          Item.item(TipoItem.carneCrua, qtd: 1),
          if (_rng.nextDouble() < 0.5) Item.item(TipoItem.ovo),
        ];
      case TipoMob.porco:
        return [
          Item.item(TipoItem.carneCrua, qtd: 1 + _rng.nextInt(3)),
        ];
      case TipoMob.zumbi:
        return [
          if (_rng.nextDouble() < 0.6)
            Item.item(TipoItem.carnePodre, qtd: _rng.nextBool() ? 1 : 2),
        ];
    }
  }
}

enum _Cat { pickable, axable, shovel, outro }
