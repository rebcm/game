import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tip/data/providers/hardcoded_content_provider.dart';
import 'package:game/features/tip/data/repositories/tip_repository.dart';

void main() {
  test('getTip returns a tip from the content provider', () async {
    final provider = HardcodedContentProvider();
    final repository = TipRepository(provider);
    final tip = await repository.getTip();
    expect(tip, 'This is a hardcoded tip');
  });
}
