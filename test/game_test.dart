import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';

void main() {
  testWidgets('Game widget is created', (tester) async {
    await tester.pumpWidget(Game());
    expect(find.text('Game'), findsOneWidget);
  });
}
