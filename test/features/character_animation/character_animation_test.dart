import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/character_animation/character_animation.dart';

void main() {
  testWidgets('CharacterAnimation widget builds without error', (tester) async {
    await tester.pumpWidget(CharacterAnimation());
    expect(find.byType(CharacterAnimation), findsOneWidget);
  });
}
