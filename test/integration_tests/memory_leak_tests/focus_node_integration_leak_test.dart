import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:leak_tracker/leak_tracker.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('FocusNode integration test for memory leak', (tester) async {
    await LeakTracker.startTracking();
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    await LeakTracker.stopTracking();
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}

// Reuse MyApp from widget tests or create a similar test app
