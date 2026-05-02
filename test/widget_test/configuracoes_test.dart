import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:rebcm/ui/hud.dart';

void main() {
  testWidgets('Testa se o HUD exibe a autora corretamente', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // Adicione os providers necessários aqui
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Hud(),
          ),
        ),
      ),
    );

    expect(find.text(Constantes.autora), findsOneWidget);
  });
}
