import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo is properly disposed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    // Use a weak reference to check if the EstadoJogo instance is garbage collected
    final weakReference = WeakReference(estadoJogoFinder.evaluate().first);
    expect(weakReference.target, isNotNull);

    // Force garbage collection
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check if the instance is garbage collected
    expect(weakReference.target, isNull);
  });
}
