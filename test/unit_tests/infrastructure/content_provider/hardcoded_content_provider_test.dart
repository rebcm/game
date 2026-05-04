import 'package:flutter_test/flutter_test.dart';
import 'package:game/infrastructure/content_provider/hardcoded_content_provider.dart';

void main() {
  test('HardcodedContentProvider returns a tip', () async {
    final provider = HardcodedContentProvider();
    final tip = await provider.getTip();
    expect(tip, 'This is a hardcoded tip');
  });
}
