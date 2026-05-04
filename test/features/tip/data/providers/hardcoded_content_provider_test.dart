import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tip/data/providers/hardcoded_content_provider.dart';

void main() {
  test('getTip returns a hardcoded tip', () async {
    final provider = HardcodedContentProvider();
    final tip = await provider.getTip();
    expect(tip, 'This is a hardcoded tip');
  });
}
