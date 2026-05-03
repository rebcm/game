import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:your_app/widgets/three_d_scene/three_d_scene.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('3D Scene Rebuild Test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ThreeDScene()));
    await tester.pumpAndSettle();

    final rebuildFinder = find.byType(RepaintBoundary);
    expect(rebuildFinder, findsOneWidget);

    // Use tester to verify rebuilds
  });
}
