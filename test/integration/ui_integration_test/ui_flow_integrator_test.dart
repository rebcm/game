import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/ui_integration/ui_flow_integrator.dart';
import 'package:game/main/app.dart';

void main() {
  testWidgets('Testa a integração da UI', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca\'s Game'), findsOneWidget);
    await tester.tap(find.text('Ir para o Tutorial'));
    await tester.pumpAndSettle();
    expect(find.text('Tutorial'), findsOneWidget);
  });
}
