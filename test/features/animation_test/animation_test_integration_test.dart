import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:passdriver/features/animation_test/widgets/animation_test_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Animation integration test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AnimationTestWidget()));
    await tester.tap(find.text('Other State'));
    await tester.pumpAndSettle();
    expect(find.byType(AnimationTest), findsOneWidget);
    await tester.tap(find.text('Idle'));
    await tester.pumpAndSettle();
    expect(find.byType(AnimationTest), findsOneWidget);
  });
}
