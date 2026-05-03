import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tips/context_mapping/tip_context_mapper.dart';

void main() {
  group('TipContextMapper', () {
    test('should return correct tip contexts', () {
      final contexts = TipContextMapper.getTipContexts();
      expect(contexts, isNotEmpty);
      expect(contexts['construction_screen'], contains('block_selection'));
    });

    test('shouldShowTooltip returns true for valid context and trigger', () {
      expect(TipContextMapper.shouldShowTooltip('construction_screen', 'block_selection'), isTrue);
    });

    test('shouldShowModal returns true for valid context and trigger', () {
      expect(TipContextMapper.shouldShowModal('construction_screen', 'first_block_placement'), isTrue);
    });
  });
}
