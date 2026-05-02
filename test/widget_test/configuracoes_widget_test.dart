import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/ui/hud.dart';

void main() {
  testWidgets('Testa se o HUD é renderizado corretamente', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [],
        child: MaterialApp(
          home: Scaffold(
            body: Hud(),
          ),
        ),
      ),
    );

    expect(find.byType(Hud), findsOneWidget);
  });
}
