import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/inventario/inventario.dart';
import 'package:rebcm/inventario/item.dart';

/// Receita de crafting: consome itens (bloco ou item) e produz um item.
class Receita {
  final List<CustoReceita> custos;
  final Item resultado;
  final bool requerWorkbench;

  const Receita({
    required this.custos,
    required this.resultado,
    this.requerWorkbench = false,
  });

  String get nome => resultado.nome;

  /// Texto curto descrevendo os custos para a UI: "3× pranchas, 2× pau".
  String get textoCustos {
    return custos
        .map((c) => '${c.qtd}× ${c.bloco != null ? c.bloco!.nome : c.item!.nome}')
        .join(' + ');
  }
}

class CustoReceita {
  final TipoBloco? bloco;
  final TipoItem? item;
  final int qtd;
  const CustoReceita.bloco(TipoBloco b, this.qtd) : bloco = b, item = null;
  const CustoReceita.item(TipoItem i, this.qtd) : bloco = null, item = i;
}

// Aliases curtos usados internamente nas tabelas de receita.
typedef _Custo = CustoReceita;

/// Receitas hardcoded estilo Minecraft. Receitas básicas (sem workbench)
/// usam só pranchas; receitas avançadas (com workbench) habilitam ferramentas.
class Crafting {
  static final List<Receita> receitas = [
    // Madeira → 4 pranchas (sem workbench)
    Receita(
      custos: [const _Custo.bloco(TipoBloco.madeira, 1)],
      resultado: Item.item(TipoItem.pranchas, qtd: 4),
    ),
    // 2 pranchas → 4 paus (sem workbench)
    Receita(
      custos: [_Custo.item(TipoItem.pranchas, 2)],
      resultado: Item.item(TipoItem.pau, qtd: 4),
    ),
    // 4 pranchas → 1 workbench (bloco oficial)
    Receita(
      custos: [_Custo.item(TipoItem.pranchas, 4)],
      resultado: Item.bloco(TipoBloco.workbench),
    ),
    // 1 carvão + 1 pau → 4 tochas (sem workbench)
    Receita(
      custos: [_Custo.item(TipoItem.carvao, 1), _Custo.item(TipoItem.pau, 1)],
      resultado: Item.bloco(TipoBloco.tocha, qtd: 4),
    ),
    // 4 lã → bandeira/cama (placeholder usando tijolo decorativo) — pulamos
    // 8 pedras (cobblestone) ainda não diferenciadas, então não há fornalha
    // 3 pranchas + 2 paus → picareta de madeira (workbench)
    Receita(
      custos: [_Custo.item(TipoItem.pranchas, 3), _Custo.item(TipoItem.pau, 2)],
      resultado: Item.item(TipoItem.picaretaMadeira),
      requerWorkbench: true,
    ),
    // 3 pedras + 2 paus → picareta de pedra
    Receita(
      custos: [_Custo.bloco(TipoBloco.pedra, 3), _Custo.item(TipoItem.pau, 2)],
      resultado: Item.item(TipoItem.picaretaPedra),
      requerWorkbench: true,
    ),
    // 3 lingotes ferro + 2 paus → picareta de ferro
    Receita(
      custos: [_Custo.item(TipoItem.ferro, 3), _Custo.item(TipoItem.pau, 2)],
      resultado: Item.item(TipoItem.picaretaFerro),
      requerWorkbench: true,
    ),
    // 3 diamantes + 2 paus → picareta de diamante
    Receita(
      custos: [_Custo.item(TipoItem.diamante, 3), _Custo.item(TipoItem.pau, 2)],
      resultado: Item.item(TipoItem.picaretaDiamante),
      requerWorkbench: true,
    ),
    // Espadas
    Receita(
      custos: [_Custo.item(TipoItem.pranchas, 2), _Custo.item(TipoItem.pau, 1)],
      resultado: Item.item(TipoItem.espadaMadeira),
      requerWorkbench: true,
    ),
    Receita(
      custos: [_Custo.bloco(TipoBloco.pedra, 2), _Custo.item(TipoItem.pau, 1)],
      resultado: Item.item(TipoItem.espadaPedra),
      requerWorkbench: true,
    ),
    Receita(
      custos: [_Custo.item(TipoItem.ferro, 2), _Custo.item(TipoItem.pau, 1)],
      resultado: Item.item(TipoItem.espadaFerro),
      requerWorkbench: true,
    ),
    // Carne crua → cozida (precisa de "fogo" — usamos lava como proxy de fornalha)
    Receita(
      custos: [_Custo.item(TipoItem.carneCrua, 1), _Custo.item(TipoItem.carvao, 1)],
      resultado: Item.item(TipoItem.carneCozida),
    ),
  ];

  /// Receitas que o jogador consegue craftar com o inventário atual.
  /// Se [perto] for false (sem workbench), filtra requerWorkbench.
  static List<Receita> disponiveis(Inventario inv, {required bool perto}) {
    final out = <Receita>[];
    for (final r in receitas) {
      if (r.requerWorkbench && !perto) continue;
      if (_temMateriais(inv, r)) out.add(r);
    }
    return out;
  }

  static bool _temMateriais(Inventario inv, Receita r) {
    for (final c in r.custos) {
      final temQ = c.bloco != null
          ? inv.contarBloco(c.bloco!)
          : inv.contarItem(c.item!);
      if (temQ < c.qtd) return false;
    }
    return true;
  }

  /// Tenta craftar [r], consumindo materiais e adicionando o resultado.
  /// Retorna `true` se sucesso.
  static bool craftar(Inventario inv, Receita r, {required bool perto}) {
    if (r.requerWorkbench && !perto) return false;
    if (!_temMateriais(inv, r)) return false;
    for (final c in r.custos) {
      if (c.bloco != null) {
        inv.consumirBloco(c.bloco!, c.qtd);
      } else {
        inv.consumirItem(c.item!, c.qtd);
      }
    }
    inv.adicionar(r.resultado.clone());
    return true;
  }
}
