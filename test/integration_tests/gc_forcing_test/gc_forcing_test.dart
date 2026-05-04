import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'dart:developer' as dev;

void main() {
  testWidgets('GC Forcing Test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Force GC
    dev.DebuggerService.getIsolateForId('main')?.then((isolate) {
      isolate.invokeRpc('_collectAllGarbage', {});
    });

    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
