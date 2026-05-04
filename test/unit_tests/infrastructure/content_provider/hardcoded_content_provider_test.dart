import 'package:flutter_test/flutter_test.dart';
import 'package:game/infrastructure/content_provider/hardcoded_content_provider.dart';

void main() {
  group('HardcodedContentProvider', () {
    test('should get tip successfully', () async {
      final contentProvider = HardcodedContentProvider();
      final tip = await contentProvider.getTip();
      expect(tip, 'Hardcoded Tip');
    });
  });
}
