import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final gcTrigger = tester.binding.pipelineOwner.microtaskQueue.isEmpty;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                if (gcTrigger) {
                  await Future.delayed(Duration(seconds: 5));
                  // Trigger GC
                  await Future.microtask(() {});
                }
              },
              child: Text('Trigger GC'),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final SerializableFinder button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(gcTrigger, true);
  });
}
