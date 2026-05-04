import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Rebeca Walk Benchmark', () {
    testWidgets('Lottie Animation Benchmark', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Navigate to Lottie animation screen
      // Assume there's a button to navigate to Lottie screen
      await tester.tap(find.text('Lottie'));
      await tester.pumpAndSettle();

      final lottieFinder = find.byType(Lottie);
      expect(lottieFinder, findsOneWidget);

      await tester.pump(Duration(seconds: 10)); // Run for 10 seconds
    });

    testWidgets('Rive Animation Benchmark', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Navigate to Rive animation screen
      // Assume there's a button to navigate to Rive screen
      await tester.tap(find.text('Rive'));
      await tester.pumpAndSettle();

      final riveFinder = find.byType(RiveAnimation);
      expect(riveFinder, findsOneWidget);

      await tester.pump(Duration(seconds: 10)); // Run for 10 seconds
    });

    testWidgets('Procedural Animation Benchmark', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Navigate to Procedural animation screen
      // Assume there's a button to navigate to Procedural screen
      await tester.tap(find.text('Procedural'));
      await tester.pumpAndSettle();

      // Assume procedural animation is implemented and visible
      await tester.pump(Duration(seconds: 10)); // Run for 10 seconds
    });
  });
}
