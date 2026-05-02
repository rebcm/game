import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/ui/hud.dart';

void main() {
  testWidgets('HUD displays correctly', (tester) async {
    await tester.pumpWidget(HUD());
    expect(find.byType(HUD), findsOneWidget);
  });
}
