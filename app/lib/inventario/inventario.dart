import 'package:flutter/foundation.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/inventario/item.dart';

/// Inventário do jogador com 36 slots (9 hotbar + 27 bag).
///
/// Os primeiros 9 slots são a hotbar (visível em baixo da tela).
/// Os 27 slots restantes só aparecem ao abrir a bag.
class Inventario extends ChangeNotifier {
  static const int slotsHotbar = 9;
  static const int slotsBag = 27;
  static const int slotsTotal = slotsHotbar + slotsBag;

  final List<Item?> slots = List<Item?>.filled(slotsTotal, null, growable: false);
  int slotSelecionado = 0;

  /// Item atualmente selecionado na hotbar (pode ser null se slot vazio).
  Item? get itemSelecionado => slots[slotSelecionado];

  /// O bloco que será colocado pelo "Colocar" (apenas se slot atual é bloco).
  TipoBloco? get blocoSelecionado {
    final it = itemSelecionado;
    if (it == null || !it.isBloco) return null;
    return it.bloco;
  }

  void selecionarSlot(int idx) {
    if (idx < 0 || idx >= slotsHotbar) return;
    slotSelecionado = idx;
    notifyListeners();
  }

  /// Tenta adicionar [novo] ao inventário, empilhando em slots existentes
  /// e usando slots vazios. Retorna `true` se TUDO coube, `false` se
  /// alguma quantidade foi descartada por falta de espaço.
  bool adicionar(Item novo) {
    var resto = novo.clone();
    // 1) Tenta empilhar em slots existentes do mesmo tipo.
    for (int i = 0; i < slotsTotal; i++) {
      final s = slots[i];
      if (s == null) continue;
      if (!s.combina(resto)) continue;
      final sobra = s.empilhar(resto);
      if (sobra == null) {
        notifyListeners();
        return true;
      }
      resto = sobra;
    }
    // 2) Coloca o resto em slots vazios.
    for (int i = 0; i < slotsTotal; i++) {
      if (slots[i] != null) continue;
      slots[i] = resto.clone();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  /// Consome 1 unidade do item no slot atual; remove slot se zerar.
  void consumirSlotAtual() {
    final s = slots[slotSelecionado];
    if (s == null) return;
    s.qtd -= 1;
    if (s.qtd <= 0) slots[slotSelecionado] = null;
    notifyListeners();
  }

  /// Consome [n] de um TipoItem específico (qualquer slot). Retorna quanto
  /// efetivamente consumiu.
  int consumirItem(TipoItem t, int n) {
    var restante = n;
    for (int i = 0; i < slotsTotal && restante > 0; i++) {
      final s = slots[i];
      if (s == null || !s.isItem || s.item != t) continue;
      final mover = s.qtd < restante ? s.qtd : restante;
      s.qtd -= mover;
      restante -= mover;
      if (s.qtd <= 0) slots[i] = null;
    }
    if (restante < n) notifyListeners();
    return n - restante;
  }

  /// Consome [n] de um TipoBloco específico em qualquer slot. Retorna
  /// quanto efetivamente consumiu.
  int consumirBloco(TipoBloco b, int n) {
    var restante = n;
    for (int i = 0; i < slotsTotal && restante > 0; i++) {
      final s = slots[i];
      if (s == null || !s.isBloco || s.bloco != b) continue;
      final mover = s.qtd < restante ? s.qtd : restante;
      s.qtd -= mover;
      restante -= mover;
      if (s.qtd <= 0) slots[i] = null;
    }
    if (restante < n) notifyListeners();
    return n - restante;
  }

  int contarItem(TipoItem t) {
    var total = 0;
    for (final s in slots) {
      if (s != null && s.isItem && s.item == t) total += s.qtd;
    }
    return total;
  }

  int contarBloco(TipoBloco b) {
    var total = 0;
    for (final s in slots) {
      if (s != null && s.isBloco && s.bloco == b) total += s.qtd;
    }
    return total;
  }

  /// Trocar item entre dois slots (drag-drop simplificado).
  void trocar(int a, int b) {
    if (a < 0 || a >= slotsTotal) return;
    if (b < 0 || b >= slotsTotal) return;
    final tmp = slots[a];
    slots[a] = slots[b];
    slots[b] = tmp;
    notifyListeners();
  }

  /// Maior tier de picareta no inventário (para gating de mineração).
  TierFerramenta get melhorPicareta {
    var melhor = TierFerramenta.mao;
    for (final s in slots) {
      if (s == null || !s.isItem) continue;
      if (s.item!.ferramenta != TipoFerramenta.picareta) continue;
      if (s.item!.tier.index > melhor.index) melhor = s.item!.tier;
    }
    return melhor;
  }

  /// Maior tier de espada (para dano em combate).
  TierFerramenta get melhorEspada {
    var melhor = TierFerramenta.mao;
    for (final s in slots) {
      if (s == null || !s.isItem) continue;
      if (s.item!.ferramenta != TipoFerramenta.espada) continue;
      if (s.item!.tier.index > melhor.index) melhor = s.item!.tier;
    }
    return melhor;
  }

  void limpar() {
    for (int i = 0; i < slotsTotal; i++) {
      slots[i] = null;
    }
    slotSelecionado = 0;
    notifyListeners();
  }
}
