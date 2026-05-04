import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Verifica se a aplicação inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca\'s Game'), findsOneWidget);
  });
}
