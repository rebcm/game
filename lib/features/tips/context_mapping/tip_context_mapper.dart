import 'package:flutter/material.dart';

class TipContextMapper {
  static Map<String, List<String>> getTipContexts() {
    return {
      'construction_screen': ['block_selection', 'toolbar_interaction'],
      'inventory_screen': ['item_drag', 'item_drop'],
    };
  }

  static bool shouldShowTooltip(String context, String trigger) {
    final contexts = getTipContexts()[context];
    return contexts != null && contexts.contains(trigger);
  }

  static bool shouldShowModal(String context, String trigger) {
    // For now, modals are shown on specific contexts and triggers
    // This logic can be expanded as needed
    return context == 'construction_screen' && trigger == 'first_block_placement';
  }
}
