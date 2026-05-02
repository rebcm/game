import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Onboarding test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verificar se o onboarding é exibido
    expect(find.text('Bem-vindo ao Rebeca\'s World!'), findsOneWidget);

    // Simular interação do usuário
    await tester.tap(find.text('Próximo'));
    await tester.pumpAndSettle();

    // Verificar se a tela de instruções é exibida
    expect(find.text('Como construir'), findsOneWidget);

    // Simular interação do usuário
    await tester.tap(find.text('Próximo'));
    await tester.pumpAndSettle();

    // Verificar se a tela inicial do jogo é exibida
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
