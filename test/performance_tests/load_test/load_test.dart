import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('load test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Define os valores mínimo, médio e máximo para densidade de blocos e distância de renderização
    List<int> blockDensityValues = [10, 50, 100];
    List<int> renderDistanceValues = [5, 10, 15];

    for (int blockDensity in blockDensityValues) {
      for (int renderDistance in renderDistanceValues) {
        // Configura a densidade de blocos e a distância de renderização
        await tester.tap(find.byTooltip('Configurar'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField).at(0), blockDensity.toString());
        await tester.enterText(find.byType(TextField).at(1), renderDistance.toString());
        await tester.tap(find.text('Salvar'));
        await tester.pumpAndSettle();

        // Verifica o desempenho
        await tester.pump(Duration(seconds: 5)); // Aguarda o sistema se estabilizar
        expect(find.byType(GameWidget), findsOneWidget);
      }
    }
  });
}
