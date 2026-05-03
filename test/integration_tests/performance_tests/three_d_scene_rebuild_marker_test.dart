import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:your_app/widgets/three_d_scene/three_d_scene.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('3D Scene Rebuild Marker Test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ThreeDScene()));
    await tester.pumpAndSettle();

    final markerFinder = find.text('Rebuild Marker');
    expect(markerFinder, findsNothing); // or findsOneWidget depending on the implementation

    // Use tester to verify the presence or absence of rebuild markers
  });
}
