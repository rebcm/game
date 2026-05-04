import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate text integration in different screen sizes', (tester) async {
    await tester.pumpWidget(MyApp());

    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
    await tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(360, 640);
    await tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
