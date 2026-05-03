import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dicas UI test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test dicas UI rendering in different resolutions
    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(480, 800);
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    // Test dicas UI rendering in different languages
    // await tester.binding.setLocale('pt');
    // await tester.pumpAndSettle();
    // expect(find.text('Dicas'), findsOneWidget);

    // await tester.binding.setLocale('en');
    // await tester.pumpAndSettle();
    // expect(find.text('Tips'), findsOneWidget);
  });
}
