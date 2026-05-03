import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('EstadoJogo dispõe corretamente os timers', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final estadoJogo = tester.state<EstadoJogoState>(find.byType(EstadoJogo));

    expect(LeakTrackingTestResult(
      leaks: estadoJogo.timersLeaks,
    ).isNotLeaky, isTrue);
  });
}
