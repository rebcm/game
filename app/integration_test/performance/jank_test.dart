import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Idle animation jank test', (tester) async {
    app.main();
    await tester.pumpAndSettle(Duration(seconds: 2));

    final Finder rebeca = find.byType(Image);
    expect(rebeca, findsOneWidget);

    final Offset initialPosition = tester.getCenter(rebeca);
    await tester.pumpAndSettle();

    final Stopwatch stopwatch = Stopwatch()..start();
    int frames = 0;
    while (stopwatch.elapsedMilliseconds < 10000) {
      await tester.pump();
      frames++;
    }

    final Offset finalPosition = tester.getCenter(rebeca);
    expect(initialPosition, finalPosition);

    final double fps = frames / (stopwatch.elapsedMilliseconds / 1000);
    print('FPS: $fps');
    expect(fps, greaterThan(30));
  });
}
