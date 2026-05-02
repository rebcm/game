import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/player/player.dart';

void main() {
  testWidgets('RebecaPlayer widget test', (tester) async {
    await tester.pumpWidget(RebecaPlayer());
    expect(find.byType(RebecaPlayer), findsOneWidget);
  });
}
