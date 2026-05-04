import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('FPS Stress Test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Simulate rapid chunk transitions
    for (int i = 0; i < 100; i++) {
      await tester.drag(find.byType(Slider), const Offset(10, 0));
      await tester.pump();
    }

    // Verify FPS
    final fps = await tester.binding.frameRate;
    expect(fps, greaterThanOrEqualTo(30));
  });
}
