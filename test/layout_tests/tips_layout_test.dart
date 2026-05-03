import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/tips_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('Tips layout test with different locales', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', ''),
          Locale('es', ''),
        ],
        home: const TipsWidget(),
      ),
    );

    await tester.pumpAndSettle();

    // Test with different locales
    await tester.binding.window.localeTestProperty('en');
    await tester.pumpAndSettle();

    await tester.binding.window.localeTestProperty('pt');
    await tester.pumpAndSettle();

    await tester.binding.window.localeTestProperty('es');
    await tester.pumpAndSettle();

    expect(find.text(Intl.message('tip')), findsOneWidget);
  });
}
