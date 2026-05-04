import 'package:flutter_test/flutter_test.dart';

Future<void> simulateSimultaneousInput(WidgetTester tester) async {
  await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
  await tester.tap(find.byType(GestureDetector));
  await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowRight);
}
