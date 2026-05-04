import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Test simultaneous keyboard and touch input', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate keyboard input
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();

    // Simulate touch input
    await tester.tapAt(Offset(100, 100));
    await tester.pump();

    // Verify expected behavior
    expect(find.text('Expected output'), findsOneWidget);
  });
}
