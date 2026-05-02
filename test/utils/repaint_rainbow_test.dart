import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/repaint_rainbow.dart';

void main() {
  testWidgets('RepaintRainbow wraps child with RepaintBoundary', (tester) async {
    final child = Container();
    final repaintRainbow = RepaintRainbow(child: child);

    await tester.pumpWidget(repaintRainbow);

    expect(find.byType(RepaintBoundary), findsOneWidget);
  });
}
