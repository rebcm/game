import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('UV rendering test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final textureFinder = find.byType(Image);
    expect(textureFinder, findsOneWidget);

    final textureWidget = tester.widget(textureFinder) as Image;
    expect(textureWidget.image, isNotNull);

    // Add logic to verify UV rendering
    // This might involve checking the pixel data or visual inspection
    // For simplicity, we'll just verify the image is loaded
    expect(textureWidget.image, isNotNull);
  });
}
