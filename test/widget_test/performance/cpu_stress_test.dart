import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('CPU Stress Test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Perform actions to stress test CPU
    await tester.tap(find.byTooltip('Build'));
    await tester.pumpAndSettle(Duration(seconds: 10));

    // Verify that the app is still responsive
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
