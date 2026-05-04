import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Renderização 3D sem interpolação', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final textureFinder = find.byType(Image);
    expect(textureFinder, findsOneWidget);

    final Image textureImage = tester.widget(textureFinder);
    expect(textureImage.filterQuality, FilterQuality.none);
  });
}
