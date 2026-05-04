import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PNG rendering test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final imageWidget = imageFinder.evaluate().first.widget as Image;
    expect(imageWidget.image, isNotNull);

    await expectLater(
      imageWidget.image,
      matchesGoldenFile('test/integration_tests/rendering_test/rendering_test.png'),
    );
  });
}
