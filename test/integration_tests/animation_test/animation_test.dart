import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Animation Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final idleStateWidget = find.byKey(Key('idle_state'));
    final transitionButton = find.byKey(Key('transition_button'));

    expect(idleStateWidget, findsOneWidget);
    await tester.tap(transitionButton);
    await tester.pumpAndSettle();

    final otherStateWidget = find.byKey(Key('other_state'));
    expect(otherStateWidget, findsOneWidget);
    expect(find.text('Other State'), findsOneWidget);
  });
}
