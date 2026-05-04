import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate tip visibility during gameplay', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Build tip 1'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('Build tip 2'), findsOneWidget);
  });

  testWidgets('validate tip navigation', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.navigate_next));
    await tester.pumpAndSettle();
    expect(find.text('Build tip 2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.navigate_before));
    await tester.pumpAndSettle();
    expect(find.text('Build tip 1'), findsOneWidget);
  });
}
