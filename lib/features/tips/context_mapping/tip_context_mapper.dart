import 'package:flutter/material.dart';

class TipContextMapper {
  static Map<String, List<String>> getTipContexts() {
    return {
      'construction_screen': ['block_selection', 'block_placement'],
      'inventory_screen': ['item_selection'],
    };
  }

  static bool shouldShowTooltip(String context, String trigger) {
    final contexts = getTipContexts()[context];
    return contexts != null && contexts.contains(trigger);
  }

  static bool shouldShowModal(String context, String trigger) {
    // For now, modals are shown for all other cases not covered by tooltips
    return !shouldShowTooltip(context, trigger);
  }
}
