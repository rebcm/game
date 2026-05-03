import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/tela_dicas.dart';

void main() {
  testWidgets('Tela de dicas responsividade test', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);
    await tester.binding.setSurfaceSize(const Size(480, 800));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);
  });

  testWidgets('Tela de dicas internacionalizacao test', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('pt', 'BR'),
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('en', 'US'),
        home: Scaffold(
          body: TelaDicas(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Tips'), findsOneWidget);
  });
}
