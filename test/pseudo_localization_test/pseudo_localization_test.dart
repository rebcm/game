import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:intl/intl.dart';

void main() {
  testWidgets('pseudo-localization test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('en', 'US'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
        ],
        home: app.MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Simulate pseudo-localization by expanding text
    await tester.binding.setLocale('en', 'US');
    Intl.defaultLocale = 'en_US';

    // Verify text wrapping/ellipsis behavior
    expect(find.text('Expanded text'), findsOneWidget);
    expect(find.byType(TextOverflow.ellipsis), findsOneWidget);
  });
}
