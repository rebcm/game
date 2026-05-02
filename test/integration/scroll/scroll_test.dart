// Similar to integration_test/scroll_test.dart but for unit testing specific components
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/ui/hud.dart';

void main() {
  group('Scroll Component Test', () {
    testWidgets('scroll component test', (tester) async {
      await tester.pumpWidget(Hotbar());

      // Test scroll functionality
      await tester.drag(find.byType(Scrollable), Offset(0, -100));
      await tester.pumpAndSettle();

      // Verify the result
      expect(find.text('Block 1'), findsWidgets);
    });
  });
}
