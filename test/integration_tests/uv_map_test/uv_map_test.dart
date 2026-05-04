import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('UV Map Test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final textureFinder = find.byType(Image);
    expect(textureFinder, findsOneWidget);

    final imageWidget = tester.widget<Image>(textureFinder);
    expect(imageWidget.image, isNotNull);

    // Add logic to verify UV coordinates
    // For demonstration, assuming we're checking if the image is rendered correctly
    final imageElement = tester.element(textureFinder);
    final renderObject = imageElement.renderObject;
    expect(renderObject, isNotNull);

    // Since we're not directly accessing the UV coordinates,
    // we'll verify the rendered output visually or through other means
    await expectLater(textureFinder, matchesGoldenFile('uv_map_test_golden.png'));
  });
}
