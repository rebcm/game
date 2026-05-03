import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/debug_logger.dart';
import 'package:game/widgets/debug_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('DebugOverlay is visible when debugLogger is enabled', (tester) async {
    final debugLogger = DebugLogger();
    debugLogger.toggle();
    await tester.pumpWidget(
      ChangeNotifierProvider<DebugLogger>(
        create: (_) => debugLogger,
        child: MaterialApp(
          home: Scaffold(
            body: DebugOverlay(),
          ),
        ),
      ),
    );
    expect(find.text('Debug Mode'), findsOneWidget);
  });

  testWidgets('DebugOverlay is not visible when debugLogger is disabled', (tester) async {
    final debugLogger = DebugLogger();
    await tester.pumpWidget(
      ChangeNotifierProvider<DebugLogger>(
        create: (_) => debugLogger,
        child: MaterialApp(
          home: Scaffold(
            body: DebugOverlay(),
          ),
        ),
      ),
    );
    expect(find.text('Debug Mode'), findsNothing);
  });
}
