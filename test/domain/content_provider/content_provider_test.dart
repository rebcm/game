import 'package:flutter_test/flutter_test.dart';
import 'package:game/domain/content_provider/content_provider.dart';
import 'package:game/infrastructure/content_provider/hardcoded_content_provider.dart';

void main() {
  test('HardcodedContentProvider returns a tip', () async {
    final contentProvider = HardcodedContentProvider();
    final tip = await contentProvider.getTip();
    expect(tip, isNotEmpty);
  });
}
