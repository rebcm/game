import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('load test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Define the matrix of test values for block density and render distance
    List<int> blockDensities = [10, 50, 100];
    List<int> renderDistances = [5, 10, 15];

    for (int blockDensity in blockDensities) {
      for (int renderDistance in renderDistances) {
        // Set the block density and render distance
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Block Density'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), blockDensity.toString());
        await tester.pumpAndSettle();
        await tester.tap(find.text('Render Distance'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), renderDistance.toString());
        await tester.pumpAndSettle();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        // Measure the performance
        await tester.pumpAndSettle();
        double fps = await tester.binding.frameRate;
        print('Block Density: $blockDensity, Render Distance: $renderDistance, FPS: $fps');
      }
    }
  });
}
