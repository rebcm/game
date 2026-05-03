import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Memory leak test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final navigator = tester.widget<Navigator>(find.byType(Navigator));
    final navigatorKey = navigator.key as GlobalKey<NavigatorState>;

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(navigatorKey.currentState?.overlay, isNotNull);

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(navigatorKey.currentState?.overlay, isNotNull);

    await expectLater(
      LeakChecker.checkLeaks(),
      areNotLeaking(),
    );
  });
}
