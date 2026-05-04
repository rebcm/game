import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('UI Resolution Test', () {
    testWidgets('should display tips screen without text overflow on small devices', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Dicas'));
      await tester.pumpAndSettle();
      expect(find.text('Texto de dica muito longo que pode causar overflow'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should display tips screen without text overflow on medium devices', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Dicas'));
      await tester.pumpAndSettle();
      expect(find.text('Texto de dica muito longo que pode causar overflow'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should display tips screen without text overflow on large devices', (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 732));
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Dicas'));
      await tester.pumpAndSettle();
      expect(find.text('Texto de dica muito longo que pode causar overflow'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}

extension WidgetTesterExtensions on WidgetTester {
  Future<void> bindingSetSurfaceSize(Size size) async {
    await binding.setSurfaceSize(size);
  }
}
