import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Dicas Golden Tests', () {
    testWidgets('Small Resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667)); // Small resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(DicasWidget),
        matchesGoldenFile('dicas_small.png'),
      );
    });

    testWidgets('Medium Resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // Medium resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(DicasWidget),
        matchesGoldenFile('dicas_medium.png'),
      );
    });

    testWidgets('Large Resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920)); // Large resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(DicasWidget),
        matchesGoldenFile('dicas_large.png'),
      );
    });
  });
}
