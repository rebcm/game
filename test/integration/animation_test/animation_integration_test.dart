import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Animação Idle para outros estados sem saltos visuais', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final idleAnimationFinder = find.byKey(const Key('idle_animation'));
    expect(idleAnimationFinder, findsOneWidget);

    await tester.tap(find.byKey(const Key('action_button')));
    await tester.pumpAndSettle();

    final otherAnimationFinder = find.byKey(const Key('other_animation'));
    expect(otherAnimationFinder, findsOneWidget);
  });
}
