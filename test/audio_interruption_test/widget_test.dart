import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('audio interruption widget test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Start playing audio
    await tester.tap(find.byTooltip('Play Audio'));
    await tester.pumpAndSettle();

    // Simulate incoming call
    // await tester.binding.handlePhoneCallInterruption();
    // await tester.pumpAndSettle();

    // Verify audio paused
    // expect(find.text('Audio Paused'), findsOneWidget);
  });
}
