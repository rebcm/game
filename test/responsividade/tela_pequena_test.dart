import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Verifica responsividade em telas pequenas', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });

  testWidgets('Verifica truncamento de dicas em telas pequenas', (tester) async {
    await tester.binding.setSurfaceSize(const Size(280, 480));
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Dicas'));
    await tester.pumpAndSettle();
    expect(find.text('Dica truncada'), findsOneWidget);
  });
}
