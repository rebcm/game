import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Testa input simultâneo de teclado e touch', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Simula input de teclado
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();

    // Simula input de touch
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verifica se o jogo processou os inputs corretamente
    expect(find.text('Bloco selecionado'), findsOneWidget);
  });

  testWidgets('Testa validação de input', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Simula input inválido
    await tester.sendKeyEvent(LogicalKeyboardKey.f1);
    await tester.pump();

    // Verifica se o jogo validou o input corretamente
    expect(find.text('Input inválido'), findsOneWidget);
  });
}

