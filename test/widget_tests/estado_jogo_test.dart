import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('EstadoJogo dispose is called when Navigator.pop is used', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final navigator = Navigator.of(tester.element(find.byType(EstadoJogo)));
    navigator.pop();

    await tester.pumpAndSettle();

    expect(LeakChecker.checkLeaks(), isEmpty);
  });

  testWidgets('EstadoJogo dispose is called when Navigator.pushReplacement is used', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final navigator = Navigator.of(tester.element(find.byType(EstadoJogo)));
    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => Scaffold()),
    );

    await tester.pumpAndSettle();

    expect(LeakChecker.checkLeaks(), isEmpty);
  });
}
