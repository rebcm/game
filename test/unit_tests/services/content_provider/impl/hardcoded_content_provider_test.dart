import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_provider/impl/hardcoded_content_provider.dart';

void main() {
  test('should return hardcoded tip', () async {
    final hardcodedContentProvider = HardcodedContentProvider();
    final tip = await hardcodedContentProvider.getTip();
    expect(tip, 'Hardcoded Tip');
  });
}
