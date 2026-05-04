import 'package:flutter_test/flutter_test.dart';
import 'package:game/content/content_fallback.dart';

void main() {
  test('Testa a hierarquia de fallback', () async {
    final contentFallback = ContentFallback();
    final content = await contentFallback.getContent();
    expect(content, isNotEmpty);
  });
}
