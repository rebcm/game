import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/widgets/cena_3d/cena_3d_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cena 3D rebuild test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Cena3DWidget(),
      ),
    );

    final repaintBoundaryFinder = find.byType(RepaintBoundary);
    expect(repaintBoundaryFinder, findsOneWidget);

    final repaintBoundary = tester.widget<RepaintBoundary>(repaintBoundaryFinder);
    // Add logic to verify rebuilds
  });
}
