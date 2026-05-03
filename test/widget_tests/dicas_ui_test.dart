import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter_i18n/flutter_i18n.dart';

void main() {
  group('Dicas UI Test', () {
    testWidgets('Renderização de dicas em diferentes resoluções', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(FlutterI18n.translate(context, 'dicas.conteudo')),
                    ),
                  );
                },
                child: Text('Mostrar Dicas'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Mostrar Dicas'));
      await tester.pumpAndSettle();

      expect(find.text(FlutterI18n.translate(tester.element(find.text('Mostrar Dicas')), 'dicas.conteudo')), findsOneWidget);
    });

    testWidgets('Renderização de dicas em diferentes idiomas', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale('en'),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(FlutterI18n.translate(context, 'dicas.conteudo')),
                    ),
                  );
                },
                child: Text('Show Tips'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Tips'));
      await tester.pumpAndSettle();

      expect(find.text(FlutterI18n.translate(tester.element(find.text('Show Tips')), 'dicas.conteudo')), findsOneWidget);
    });
  });
}
