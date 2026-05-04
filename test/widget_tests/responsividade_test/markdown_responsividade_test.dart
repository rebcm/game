import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/markdown_widget.dart';

void main() {
  group('MarkdownWidget Responsividade Test', () {
    testWidgets('deve renderizar tabelas corretamente em diferentes resoluções', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(400, 800); // Mobile
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownWidget(
              data: '| Coluna 1 | Coluna 2 |\n| --- | --- |\n| Dado 1 | Dado 2 |',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Coluna 1'), findsOneWidget);
      expect(find.text('Dado 1'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(1024, 768); // Tablet
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownWidget(
              data: '| Coluna 1 | Coluna 2 |\n| --- | --- |\n| Dado 1 | Dado 2 |',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Coluna 1'), findsOneWidget);
      expect(find.text('Dado 1'), findsOneWidget);
    });

    testWidgets('deve renderizar blocos de código corretamente em diferentes resoluções', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(400, 800); // Mobile
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownWidget(
              data: '```dart\nvoid main() {}\n```',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('void main() {}'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(1024, 768); // Tablet
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownWidget(
              data: '```dart\nvoid main() {}\n```',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('void main() {}'), findsOneWidget);
    });
  });
}
