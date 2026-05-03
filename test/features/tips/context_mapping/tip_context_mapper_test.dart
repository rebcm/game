import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tips/context_mapping/tip_context_mapper.dart';

void main() {
  group('TipContextMapper', () {
    test('should return correct tip contexts', () {
      final contexts = TipContextMapper.getTipContexts();
      expect(contexts, isNotEmpty);
      expect(contexts['construction_screen'], contains('block_selection'));
    });

    test('should determine if tooltip should be shown', () {
      expect(TipContextMapper.shouldShowTooltip('construction_screen', 'block_selection'), isTrue);
      expect(TipContextMapper.shouldShowTooltip('inventory_screen', 'block_placement'), isFalse);
    });

    test('should determine if modal should be shown', () {
      expect(TipContextMapper.shouldShowModal('construction_screen', 'unknown_trigger'), isTrue);
      expect(TipContextMapper.shouldShowModal('inventory_screen', 'item_selection'), isFalse);
    });
  });
}
