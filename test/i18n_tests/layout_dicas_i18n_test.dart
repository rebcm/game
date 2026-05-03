import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Layout de dicas deve se adaptar a diferentes idiomas', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
          Locale('es', 'ES'),
        ],
        home: Scaffold(
          body: DicasLayout(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dicas'), findsOneWidget);

    await tester.binding.window.localeTestValue = Locale('en', 'US');
    await tester.pumpAndSettle();

    expect(find.text('Tips'), findsOneWidget);

    await tester.binding.window.localeTestValue = Locale('es', 'ES');
    await tester.pumpAndSettle();

    expect(find.text('Sugerencias'), findsOneWidget);
  });
}
