import 'package:flutter_test/flutter_test.dart';
import 'package:game/domain/content_provider/content_provider_contract.dart';
import 'package:game/infrastructure/content_provider/hardcoded_content_provider.dart';

void main() {
  test('should return tip', () async {
    final contentProvider = HardcodedContentProvider();
    final tip = await contentProvider.getTip();
    expect(tip, isNotEmpty);
  });
}
