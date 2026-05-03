import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/dicas/dicas.dart';

void main() {
  testWidgets('Dicas UI Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Dicas(),
      ),
    );

    expect(find.text('Dicas'), findsOneWidget);
  });

  testWidgets('Dicas UI Test - Different Resolutions', (tester) async {
    await tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    await tester.pumpWidget(
      MaterialApp(
        home: Dicas(),
      ),
    );

    expect(find.text('Dicas'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pumpWidget(
      MaterialApp(
        home: Dicas(),
      ),
    );

    expect(find.text('Dicas'), findsOneWidget);
  });

  testWidgets('Dicas UI Test - Different Languages', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('en'),
        home: Dicas(),
      ),
    );

    expect(find.text('Tips'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('pt'),
        home: Dicas(),
      ),
    );

    expect(find.text('Dicas'), findsOneWidget);
  });
}
