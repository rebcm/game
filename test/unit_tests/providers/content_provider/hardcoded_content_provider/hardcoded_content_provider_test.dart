import 'package:flutter_test/flutter_test.dart';
import 'package:game/providers/content_provider/hardcoded_content_provider/hardcoded_content_provider.dart';

void main() {
  group('HardcodedContentProvider', () {
    test('should return a hardcoded tip', () async {
      final provider = HardcodedContentProvider();
      final tip = await provider.getTip();
      expect(tip, 'Hardcoded Tip');
    });
  });
}
