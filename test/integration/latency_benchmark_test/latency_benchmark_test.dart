import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('latency benchmark test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement latency benchmark test logic here
    // Measure the time taken for data transfer between Isolate and UI thread
    // Use tester.binding.microtaskCount to wait for microtasks to complete
    // Use DateTime.now().millisecondsSinceEpoch to measure time
  });
}

