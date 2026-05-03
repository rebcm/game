import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/game.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo is garbage collected', (tester) async {
    await tester.pumpWidget(MyApp());
    final estadoJogo = EstadoJogo();
    await tester.pumpAndSettle();

    LeakTrackingTestConfig config = LeakTrackingTestConfig(
      checkInterval: Duration(milliseconds: 100),
    );

    await expectLater(
      () async {
        await tester.runAsync(() async {
          await LeakTracker.assertNoLeaks(
            config,
            () async {
              estadoJogo.dispose();
              await tester.pumpAndSettle();
            },
          );
        });
      },
      returnsNormally,
    );
  });
}
