import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Validate text overflow in German and French', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('de', ''), // German
          Locale('fr', ''), // French
        ],
        home: Scaffold(
          body: Text('long_text_key'), // Assuming 'long_text_key' is translated
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('long_text_key'), findsOneWidget);
    expect(tester.getSize(find.text('long_text_key')).width, lessThan(200)); // Example width check
  });
}
