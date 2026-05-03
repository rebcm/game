import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('EstadoJogo não deve vazar memória', (tester) async {
    await tester.pumpWidget(
      LeakTrackingWidgetWrapper(
        child: MaterialApp(
          home: EstadoJogo(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(LeakTracking.hasLeaks(), false);

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    expect(LeakTracking.hasLeaks(), false);
  });
}
